package graph

import (
	"context"
	"gorm.io/gorm"
	"net/http"
	"time"
	"log"
	"github.com/99designs/gqlgen/graphql/handler"
	"github.com/99designs/gqlgen/graphql/handler/extension"
	"github.com/99designs/gqlgen/graphql/handler/lru"
	"github.com/99designs/gqlgen/graphql/handler/transport"
	"github.com/99designs/gqlgen/graphql/playground"
	"github.com/landrade/gqlgen-cache-control-plugin/cache"
	"github.com/vektah/gqlparser/v2/ast"
	"github.com/go-chi/chi/v5"
)

func InitGraphQL(ctx context.Context, port string, db *gorm.DB) error {
	resolver := &Resolver{DB: db}
	c := Config{ Resolvers: resolver }

	router := chi.NewRouter()

	router.Use(FilterMiddleware)
	srv := handler.New(NewExecutableSchema(c))

	srv.AddTransport(transport.Options{})
	srv.AddTransport(transport.GET{})
	srv.AddTransport(transport.POST{})

	srv.Use(cache.Extension{})

	srv.SetQueryCache(lru.New[*ast.QueryDocument](1000))

	srv.Use(extension.Introspection{})
	srv.Use(extension.AutomaticPersistedQuery{
		Cache: lru.New[string](100),
	})

	http.Handle("/", playground.Handler("GraphQL playground", "/query"))
	http.Handle("/query", cache.Middleware(srv))

	server := &http.Server{
		Addr: ":" + port,
	}

	// Handle shutdown
	go func() {
		<-ctx.Done()
		log.Println("Shutting down HTTP server...")
		shutdownCtx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
		defer cancel()
		if err := server.Shutdown(shutdownCtx); err != nil {
			log.Println("HTTP server shutdown error:", err)
		}
	}()

	// Start the server
	log.Printf("connect to http://localhost:%s/ for GraphQL playground", port)
	return server.ListenAndServe()
}
