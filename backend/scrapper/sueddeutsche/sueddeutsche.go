package sueddeutsche

import (
	"encoding/xml"
	"fmt"
	"io"
	"net/http"
	"regexp"
	"strings"
	"time"
	"news-swipe/backend/graph/model"
)

// RSS represents the RSS feed structure
type RSS struct {
	XMLName xml.Name `xml:"rss"`
	Channel Channel  `xml:"channel"`
}

type Channel struct {
	Title       string `xml:"title"`
	Link        string `xml:"link"`
	Description string `xml:"description"`
	PubDate     string `xml:"pubDate"`
	Items       []Item `xml:"item"`
}

type Item struct {
	GUID		string   `xml:"guid"`
	Title       string   `xml:"title"` 
	Link        string   `xml:"link"`
	Description string   `xml:"description"`
	PubDate     string   `xml:"pubDate"`
	Source      string   `xml:"source"`
	Author      string   `xml:"author"`
	Categories  []string `xml:"category"`
}

// stripHTML removes HTML tags and extracts text content
func stripHTML(html string) string {
	re := regexp.MustCompile(`<[^>]+>`)
	return strings.TrimSpace(re.ReplaceAllString(html, ""))
}

// extractImageURL extracts the image URL from the description
func extractImageURL(html string) string {
	re := regexp.MustCompile(`<img[^>]+src=["'](.*?)["']`)
	matches := re.FindStringSubmatch(html)
	if len(matches) > 1 {
		return matches[1]
	}
	return ""
}

// parsePubDate converts RSS pubDate to Unix timestamp (int32)
func parsePubDate(pubDate string) (time.Time, error) {
	// Replace common timezones with numeric offsets
	pubDate = strings.Replace(pubDate, "CEST", "+0200", 1)
	pubDate = strings.Replace(pubDate, "GMT", "+0000", 1)

	// Parse the date
	return time.Parse("Mon, 02 Jan 2006 15:04:05 -0700", pubDate)
}

func Scrape() ([]model.Article, error)  {
	// RSS feed URL
	rssURL := "https://rss.sueddeutsche.de/rss/Topthemen"

	// Fetch RSS feed
	resp, err := http.Get(rssURL)
	if err != nil {
		fmt.Printf("Error fetching RSS feed: %v\n", err)
		return nil, err 
	}
	defer resp.Body.Close()

	// Read response body
	body, err := io.ReadAll(resp.Body)
	if err != nil {
		fmt.Printf("Error reading response body: %v\n", err)
		return nil, err 
	}

	// Parse XML into RSS struct
	var rss RSS
	err = xml.Unmarshal(body, &rss)
	if err != nil {
		fmt.Printf("Error parsing XML: %v\n", err)
		return nil, err 
	}

	// Convert RSS items to Article slice
	articles := make([]model.Article, 0, len(rss.Channel.Items))
	for _, item := range rss.Channel.Items {
		pubDate, err := parsePubDate(item.PubDate)
		if err != nil {
			continue
		}

		article := model.Article{
			GormModel: model.GormModel{
				ID: fmt.Sprintf("%s-%s", model.SourceSueddeutsche, item.GUID),
			},
			Title:       item.Title,
			Source:      model.SourceSueddeutsche,
			PublishedAt:   pubDate,
			URI:         item.Link,
			Views:       0, // Views not provided in RSS, default to 0
			Description: stripHTML(item.Description),
			Banner:      extractImageURL(item.Description),
			Category: item.Categories,
			LinkedTo: []string{},
		}
		articles = append(articles, article)
	}	

	return articles, nil
}

