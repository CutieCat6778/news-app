package graph

import (
	"net/http"
	"context"
	"strings"
	"news-swipe/backend/graph/model"
)

var filterContextKey = &contextKey{"filter"}

type contextKey struct {
	name string
}

func FilterMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		rawFilter := r.Header.Get("Filter")
		if rawFilter == "" {
			next.ServeHTTP(w, r)
			return
		}
		filters := strings.Split(rawFilter, ",")
		sourcesFilter := make([]model.Source, 0)

		for _, filter := range filters {
			switch strings.TrimSpace(filter) {
			case model.SourceFaz.String():
				sourcesFilter = append(sourcesFilter, model.SourceFaz)
			case model.SourceDieZeit.String():
				sourcesFilter = append(sourcesFilter, model.SourceDieZeit)
			case model.SourceHandelsblatt.String():
				sourcesFilter = append(sourcesFilter, model.SourceHandelsblatt)
			case model.SourceSueddeutsche.String():
				sourcesFilter = append(sourcesFilter, model.SourceSueddeutsche)
			case model.SourceTagesschau.String():
				sourcesFilter = append(sourcesFilter, model.SourceTagesschau)
			case model.SourceWelt.String():
				sourcesFilter = append(sourcesFilter, model.SourceWelt)
			case model.SourceTaz.String():
				sourcesFilter = append(sourcesFilter, model.SourceTaz)
			}
		}
		ctx := context.WithValue(r.Context(), filterContextKey, sourcesFilter)
		next.ServeHTTP(w, r.WithContext(ctx))
	})	
}
