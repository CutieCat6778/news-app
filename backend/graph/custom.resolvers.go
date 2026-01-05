package graph

import (
	"gorm.io/gorm"
	"context"
	"news-swipe/backend/graph/model"
	"news-swipe/backend/utils"

	"github.com/99designs/gqlgen/graphql"
	"github.com/vektah/gqlparser/v2/gqlerror"
)

type Resolver struct {
	DB *gorm.DB
}

func (r *queryResolver) UpdateViews(ctx context.Context, articles []*model.Article) {
	if len(articles) == 0 {
		return
	}

	ids := make([]string, len(articles))
	for i, article := range articles {
		ids[i] = article.ID
	}

	err := r.DB.Exec(`
		UPDATE articles
		SET views = views + 1
		WHERE id IN ?
	`, ids).Error

	if err != nil {
		errStr, code := utils.HandleGormError(err)
		graphql.AddError(ctx, &gqlerror.Error{
			Path: graphql.GetPath(ctx),
			Message: errStr,
			Extensions: map[string]any{
				"code": code,
			},
		})
	}
}
