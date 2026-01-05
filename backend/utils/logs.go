package utils 

import (
	"log"
	"time"
)

type Source string

const (
	GraphQL			Source = "GraphQL"
	Cron			Source = "CronJob"
	Main			Source = "Main"
	System          Source = "System"
	Database		Source = "Database"
	Cache			Source = "Cache"
)

func Log(source Source, content ...any) {
	log.Printf("%s: [%s] %s", time.Now(), source, content)
}


