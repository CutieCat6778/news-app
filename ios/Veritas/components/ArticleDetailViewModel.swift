import Apollo
import Combine
import Foundation
import Graphql

@MainActor
final class ArticleDetailViewModel: ObservableObject {
    @Published var fetchedArticle: Article?
    @Published var isLoading = false
    @Published var error: Error?

    private var articleTask: Task<Void, Never>?

    // ISO8601 Date Formatter
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()

    deinit {
        articleTask?.cancel()
    }

    func fetchArticle(id: String) {
        articleTask?.cancel()
        isLoading = true

        articleTask = Task {
            do {
                let query = GetArticleQuery(id: id)
                let result = try await Network.shared.apollo.fetch(query: query)
                guard !Task.isCancelled else { return }

                if let articleData = result.data?.article {
                    self.fetchedArticle = mapToArticle(item: articleData)
                }
                isLoading = false
            } catch {
                guard !Task.isCancelled else { return }
                print("Error fetching article: \(error)")
                self.error = error
                isLoading = false
            }
        }
    }

    func refreshArticle(id: String) async {
        articleTask?.cancel()
        error = nil

        articleTask = Task {
            do {
                let query = GetArticleQuery(id: id)
                let result = try await Network.shared.apollo.fetch(query: query)
                guard !Task.isCancelled else { return }

                if let articleData = result.data?.article {
                    self.fetchedArticle = mapToArticle(item: articleData)
                }
            } catch {
                guard !Task.isCancelled else { return }
                print("Error refreshing article: \(error)")
                self.error = error
            }
        }

        await articleTask?.value
    }

    private func mapToArticle(item: GetArticleQuery.Data.Article) -> Article {
        let fields = item.fragments.articleFields
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
