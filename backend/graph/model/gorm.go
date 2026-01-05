package model

import (
	"time"
	"gorm.io/gorm"
	"encoding/json"
)

type GormModel struct {
  ID        string           `gorm:"primaryKey"`
  CreatedAt time.Time
  UpdatedAt time.Time
  DeletedAt gorm.DeletedAt `gorm:"index"`
}

// MarshalJSON converts Article to JSON string
func (a *Article) MarshalJSONToString() (string, error) {
	data, err := json.Marshal(a)
	if err != nil {
		return "", err
	}
	return string(data), nil
}

// UnmarshalJSONFromString converts JSON string to Article
func UnmarshalJSONFromString(article *Article, jsonStr string) error {
	return json.Unmarshal([]byte(jsonStr), article)
}
