import Apollo
import Combine
import Foundation
import Graphql

@MainActor
protocol HomePageModelProtocol: ObservableObject, AnyObject {
    var articles: [Article] { get }
    func getRecentArticles(amount: Int)
}

final class HomePageModel: HomePageModelProtocol {
    @Published var articles: [Article] = []

    // ISO8601 Date Formatter
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()

    func getRecentArticles(amount: Int) {
        Task {
            do {
                let query = GetRecentArticlesQuery(amount: Int32(amount))
                let result = try await Network.shared.apollo.fetch(query: query)

                if let fetchedData = result.data?.recentArticle {
                    self.articles = fetchedData.compactMap { self.mapToArticle(item: $0) }
                }
            } catch {
                print("Error fetching articles: \(error)")
            }
        }
    }

    private func mapToArticle(item: GetRecentArticlesQuery.Data.RecentArticle?) -> Article? {
        guard let item = item else { return nil }

        let fields = item.fragments.articleFields

        // These fields are non-optional, no need for ?? operator
        let sourceString = fields.source.rawValue
        let categories = fields.category?.compactMap { $0 } ?? []

        // Handle Linked Articles
        let linkedArticles: [Article]
        if let links = item.fragments.articleWithLinks.linkedTo, !links.isEmpty {
            linkedArticles = links.compactMap { linkedItem -> Article? in
                guard let lFields = linkedItem else { return nil }

                return Article(
                    id: lFields.id,
                    title: lFields.title,
                    source: lFields.source.rawValue,
                    publishedAt: parseDate(lFields.publishedAt),
                    uri: "",
                    views: 0,
                    description: "",
                    banner: lFields.banner,
                    linkedTo: [],
                    category: []
                )
            }
        } else {
            linkedArticles = []
        }

        return Article(
            id: fields.id,
            title: fields.title,
            source: sourceString,
            publishedAt: parseDate(fields.publishedAt),
            uri: fields.uri,
            views: fields.views,
            description: fields.description,
            banner: fields.banner,
            linkedTo: linkedArticles,
            category: categories
        )
    }

    // Helper function to parse date string to Date
    private func parseDate(_ dateString: String) -> Date {
        if let date = dateFormatter.date(from: dateString) {
            return date
        }
        // Fallback: try ISO8601DateFormatter
        if let date = ISO8601DateFormatter().date(from: dateString) {
            return date
        }
        // Last resort: return current date
        print("Warning: Could not parse date string: \(dateString)")
        return Date()
    }
}

extension Article {
    static var empty: Article {
        Article(
            id: "",
            title: "",
            source: "",
            publishedAt: Date(),
            uri: "",
            views: 0,
            description: "",
            banner: "",
            linkedTo: [],
            category: []
        )
    }
}
