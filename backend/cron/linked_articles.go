package cron 

import (
	"errors"
	"news-swipe/backend/graph/model" 
	"news-swipe/backend/utils" 
	"news-swipe/backend/scrapper/tagesschau"
	"news-swipe/backend/scrapper/zeit"
	"news-swipe/backend/scrapper/faz"
	"news-swipe/backend/scrapper/sueddeutsche"
	"news-swipe/backend/scrapper/welt"
	"news-swipe/backend/scrapper/handelsblatt"
	"news-swipe/backend/scrapper/taz"
	"gorm.io/gorm"
)

func FilterLinked(db *gorm.DB) error {
	zeitArticles, err := zeit.Scrape() 
	if err != nil {
		panic(err)
	}
	fazArticles, err := faz.Scrape() 
	if err != nil {
		panic(err)
	}
	tagesschauArticles, err := tagesschau.Scrape()
	if err != nil {
		panic(err)
	}
	sueddeutscheArticles, err := sueddeutsche.Scrape()
	if err != nil {
		panic(err)
	}
	weltArticles, err := welt.Scrape()
	if err != nil {
		panic(err)
	}
	handelsblattArticles, err := handelsblatt.Scrape()
	if err != nil {
		panic(err)
	}
	tazArticles, err := taz.Scrape()
	if err != nil {
		panic(err)
	}

	var allArticles []model.Article
	allArticles = append(allArticles, zeitArticles...)
	allArticles = append(allArticles, tagesschauArticles...)
	allArticles = append(allArticles, sueddeutscheArticles...)
	allArticles = append(allArticles, fazArticles...)
	allArticles = append(allArticles, weltArticles...)
	allArticles = append(allArticles, handelsblattArticles...)
	allArticles = append(allArticles, tazArticles...)

	utils.Log(utils.Database, len(allArticles))

	return saveDatabase(db, allArticles)	
}

func saveDatabase(db *gorm.DB, articles []model.Article) error {
	if len(articles) == 0 {
		return nil
	}

	tx := db.Session(&gorm.Session{PrepareStmt: true})

	// Collect all article IDs
	ids := make([]string, 0, len(articles))
	for _, a := range articles {
		ids = append(ids, a.ID)
	}

	// Fetch existing articles in one query
	var existing []model.Article
	if err := tx.Where("id IN ?", ids).Find(&existing).Error; err != nil {
		errStr, _ := utils.HandleGormError(err)
		return errors.New(errStr)
	}

	// Build a map of existing article IDs
	existingMap := make(map[string]struct{})
	for _, a := range existing {
		existingMap[a.ID] = struct{}{}
	}

	// Filter new articles
	var newArticles []model.Article
	for _, a := range articles {
		if _, exists := existingMap[a.ID]; !exists {
			utils.Log(utils.Database, "Creating new article: "+a.Title)
			newArticles = append(newArticles, a)
		}
	}

	// Batch insert new articles
	if len(newArticles) > 0 {
		if err := tx.CreateInBatches(newArticles, 100).Error; err != nil {
			errStr, _ := utils.HandleGormError(err)
			return errors.New(errStr)
		}
	}

	return nil
}
