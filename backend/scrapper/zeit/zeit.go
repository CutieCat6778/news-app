package zeit

import (
	"encoding/xml"
	"fmt"
	"io"
	"net/http"
	"strings"
	"time"
	"news-swipe/backend/graph/model"
)

// RSS feed structures
type RSS struct {
	XMLName xml.Name `xml:"rss"`
	Channel Channel  `xml:"channel"`
}

type Channel struct {
	Title       string `xml:"title"`
	Link        string `xml:"link"`
	Description string `xml:"description"`
	Items       []Item `xml:"item"`
}

type Item struct {
	Title       string    `xml:"title"`
	Link        string    `xml:"link"`
	Description string    `xml:"description"`
	PubDate     string    `xml:"pubDate"`
	GUID        string    `xml:"guid"`
	Enclosure   Enclosure `xml:"enclosure"`
	Categories  []string  `xml:"category"`
	Creator     string    `xml:"creator"`
	Content     string    `xml:"content:encoded"`
}

type Enclosure struct {
	URL  string `xml:"url,attr"`
	Type string `xml:"type,attr"`
}

// ScrapeZeitRSS fetches and processes the ZEIT ONLINE RSS feed
func Scrape() ([]model.Article, error) {
	rssURL := "https://newsfeed.zeit.de/index"
	// Fetch RSS feed
	resp, err := http.Get(rssURL)
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	// Read response body
	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return nil, err
	}

	// Parse RSS feed
	var rss RSS
	err = xml.Unmarshal(body, &rss)
	if err != nil {
		return nil, err
	}

	// Convert to Article structs
	articles, err := parseRSStoArticles(rss)
	if err != nil {
		return nil, err
	}

	return articles, nil
}

func parseRSStoArticles(rss RSS) ([]model.Article, error) {
	var articles []model.Article
	seenGUIDs := make(map[string]bool) // Track GUIDs to avoid duplicates

	for _, item := range rss.Channel.Items {
		// Skip duplicate items based on GUID
		if seenGUIDs[item.GUID] {
			continue
		}
		seenGUIDs[item.GUID] = true

		// Parse publication date
		pubDate, err := parsePubDate(item.PubDate)
		if err != nil {
			continue
		}

		// Get banner image from enclosure
		banner := ""
		if item.Enclosure.Type == "image/jpeg" {
			banner = item.Enclosure.URL
		}

		// Clean up CDATA and extra whitespace
		title := strings.TrimSpace(strings.ReplaceAll(item.Title, "<![CDATA[", ""))
		title = strings.TrimSpace(strings.ReplaceAll(title, "]]>", ""))
		description := strings.TrimSpace(strings.ReplaceAll(item.Description, "<![CDATA[", ""))
		description = strings.TrimSpace(strings.ReplaceAll(description, "]]>", ""))
		if description == "" && item.Content != "" {
			// Use content:encoded as fallback, removing HTML tags
			content := strings.TrimSpace(strings.ReplaceAll(item.Content, "<![CDATA[", ""))
			content = strings.TrimSpace(strings.ReplaceAll(content, "]]>", ""))
			// Basic HTML tag removal
			content = strings.ReplaceAll(content, `<a href="`+item.Link+`">`, "")
			content = strings.ReplaceAll(content, `<img style="float:left; margin-right:5px" src="`+banner+`">`, "")
			content = strings.TrimSpace(content)
			if content != "None" {
				description = content
			}
		}

		// Skip items with no description
		if description == "" {
			continue
		}

		// Convert categories to []*string
		categories := make([]string, len(item.Categories))
		for i, cat := range item.Categories {
			catCopy := cat
			categories[i] = catCopy
		}

		id := strings.TrimPrefix(item.GUID, "{urn:uuid:")
		id = strings.TrimSuffix(id, "}")

		// Create Article
		article := model.Article{
			GormModel: model.GormModel{
				ID:       fmt.Sprintf("%s-%s", model.SourceDieZeit, id),
			},
			Title: title,
			Source:      model.SourceDieZeit, // Assuming SourceZeit is defined in model
			PublishedAt:   pubDate,
			URI:         item.Link,
			Views:       0, // Not provided in RSS feed
			Description: description,
			Banner:      banner,
			Category:    categories,
			LinkedTo: []string{},
		}

		articles = append(articles, article)
	}

	return articles, nil
}

func parsePubDate(pubDate string) (time.Time, error) {
	// RSS pubDate format: Tue, 06 May 2025 20:47:22 -0000
	parsedTime, err := time.Parse("Mon, 02 Jan 2006 15:04:05 -0700", pubDate)
	if err != nil {
		return time.Time{}, err
	}
	return parsedTime, nil
}
