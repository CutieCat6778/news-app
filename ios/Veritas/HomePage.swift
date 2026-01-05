import SwiftUI

struct HomePage: View {
    let topNews: [Article] = [
        Article(title: "SwiftUI Makes Building iOS Apps Fun",
                source: "Tagesschau",
                publishedAt: Date(),
                uri: "https://example.com",
                views: 120,
                description: "SwiftUI is a modern way to declare user interfaces for Apple platforms.",
                banner: "https://picsum.photos/400/200",
                linkedTo: [],
                category: ["Tech", "Swift"]),
        Article(title: "iOS 18 Released",
                source: "DieZeit",
                publishedAt: Date(),
                uri: "https://example.com",
                views: 98,
                description: "The newest iOS version brings amazing features to iPhones and iPads.",
                banner: "https://picsum.photos/400/201",
                linkedTo: [],
                category: ["News", "iOS"]),
    ]

    let latestTech: [Article] = []
    let trending: [Article] = []
    let editorsPick: [Article] = []

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                SectionView(sectionTitle: "Top News", articles: topNews)
                SectionView(sectionTitle: "Latest Tech", articles: latestTech)
                SectionView(sectionTitle: "Trending", articles: trending)
                SectionView(sectionTitle: "Editor's Pick", articles: editorsPick)
            }
            .padding(.vertical)
        }
        .background(Color.clear)
    }
}

struct SectionView: View {
    let sectionTitle: String
    let articles: [Article]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(sectionTitle)
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 16)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(articles) { article in
                        NewsCard(article: article)
                    }
                }
                .scrollTargetLayout()
                .padding(.horizontal, 16)
            }
            .scrollTargetBehavior(.viewAligned)
        }
        .background(Color.clear)
    }
}
