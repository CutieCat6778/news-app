import Apollo
import SwiftUI

struct ArticleDetailView: View {
    let article: Article
    let pullData: Bool
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = ArticleDetailViewModel()

    private let bannerHeight: CGFloat = 250

    init(article: Article, pullData: Bool = false) {
        self.article = article
        self.pullData = pullData
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Banner Image
                AsyncImage(url: URL(string: displayArticle.banner.isEmpty ? "https://picsum.photos/400/200" : displayArticle.banner)) { phase in
                    switch phase {
                    case .empty:
                        Color.gray.opacity(0.3)
                            .frame(width: UIScreen.main.bounds.width, height: bannerHeight)
                    case let .success(image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width, height: bannerHeight)
                            .clipped()
                    case .failure:
                        Color.red.opacity(0.3)
                            .frame(width: UIScreen.main.bounds.width, height: bannerHeight)
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: UIScreen.main.bounds.width, height: bannerHeight)
                .clipped()

                VStack(alignment: .leading, spacing: 16) {
                    // Categories
                    if !displayArticle.category.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(displayArticle.category, id: \.self) { category in
                                    Text(category)
                                        .font(.caption)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(Color.blue.opacity(0.2))
                                        .foregroundColor(.blue)
                                        .clipShape(Capsule())
                                }
                            }
                        }
                    }

                    // Title
                    Text(displayArticle.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)

                    // Source and Date
                    HStack {
                        Text(displayArticle.source)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                            .truncationMode(.tail)

                        Spacer()

                        HStack(spacing: 4) {
                            Text(displayArticle.publishedAt, style: .date)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("•")
                                .foregroundColor(.secondary)
                            Text(displayArticle.publishedAt, style: .time)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .lineLimit(1)
                    }

                    // Views
                    HStack(spacing: 4) {
                        Image(systemName: "eye.fill")
                            .font(.caption)
                        Text("\(displayArticle.views) views")
                            .font(.caption)
                    }
                    .foregroundColor(.secondary)

                    Divider()

                    // Description
                    Text(displayArticle.description)
                        .font(.body)
                        .foregroundColor(.primary)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)

                    // Read Full Article Button
                    if let url = URL(string: displayArticle.uri) {
                        Link(destination: url) {
                            HStack {
                                Text("articledetailview_read_full_article")
                                    .fontWeight(.semibold)
                                Spacer()
                                Image(systemName: "arrow.up.right")
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }

                    // Linked Articles Section
                    if !displayArticle.linkedTo.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("articledetailview_related_articles")
                                .font(.title2)
                                .fontWeight(.bold)

                            ForEach(displayArticle.linkedTo) { linkedArticle in
                                NavigationLink(destination: ArticleDetailView(article: linkedArticle, pullData: true)) {
                                    LinkedArticleCard(article: linkedArticle)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.top, 8)
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if pullData {
                viewModel.fetchArticle(id: article.id)
            }
        }
    }

    private var displayArticle: Article {
        viewModel.fetchedArticle ?? article
    }
}
