package main

import (
	"log"
	"time"
	"os/signal"
	"os"
	"net/http"
	"news-swipe/backend/graph"
	"news-swipe/backend/cron"
	"news-swipe/backend/utils"
	"context"
	"gorm.io/gorm"
	"gorm.io/driver/postgres"
    "github.com/joho/godotenv"
)

const defaultPort = "8080"

func main() {
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()

	err := godotenv.Load()
	if err != nil {
		log.Fatal("Error loading .env file")
	}

	port := os.Getenv("PORT")
	if port == "" {
		port = defaultPort
	}

	connStr := os.Getenv("POSTGRESQL_URI")
	if connStr == "" {
		panic("No DB")
	}
	
	db, err := gorm.Open(postgres.Open(connStr), &gorm.Config{
		SkipDefaultTransaction: true,
	})
	if err != nil {
		log.Fatal(err)
	}

	//db.AutoMigrate(&model.Article{})

	go cron.CreateCron(ctx, db) 

	go func() {
		if err := graph.InitGraphQL(ctx, port, db); err != nil && err != http.ErrServerClosed {
			utils.Log(utils.GraphQL, "HTTP server error: ", err)
		}
	}()

	sigCh := make(chan os.Signal, 1)
	signal.Notify(sigCh, os.Interrupt)
	utils.Log(utils.System, "Program started")	
	<-sigCh
	
	utils.Log(utils.System, "Initiating shutdown")
	cancel()

	time.Sleep(time.Second)
	utils.Log(utils.System, "Program exited")
}
