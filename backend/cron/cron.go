package cron

import (
	"gorm.io/gorm"
	"github.com/robfig/cron/v3"
	"context"
	"news-swipe/backend/utils"
)

func CreateCron(ctx context.Context, db *gorm.DB) {
	err := FilterLinked(db)
	if err != nil {
	 	utils.Log(utils.Database, err)
	}
	c := cron.New(cron.WithChain(cron.Recover(cron.DefaultLogger)))

	_, err = c.AddFunc("*/15 * * * *", func() {
		err := FilterLinked(db)
		if err != nil {
			utils.Log(utils.Database, err)
		}
	})
	if err != nil {
		panic(err)
	}

	c.Start()
	utils.Log(utils.Cron, "CronJob is started")
	<-ctx.Done()
	utils.Log(utils.Cron, "CronJob is shutedown")
	c.Stop()
}
