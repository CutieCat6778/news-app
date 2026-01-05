// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
@testable import Graphql

public final class Article: MockObject {
  public static let objectType: ApolloAPI.Object = Graphql.Objects.Article
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Article>>

  public struct MockFields: Sendable {
    @Field<String>("banner") public var banner
    @Field<[String?]>("category") public var category
    @Field<String>("description") public var description
    @Field<Graphql.ID>("id") public var id
    @Field<[Article?]>("linkedTo") public var linkedTo
    @Field<String>("publishedAt") public var publishedAt
    @Field<GraphQLEnum<Graphql.Source>>("source") public var source
    @Field<String>("title") public var title
    @Field<String>("uri") public var uri
    @Field<Int>("views") public var views
  }
}

public extension Mock where O == Article {
  convenience init(
    banner: String = "",
    category: [String?]? = nil,
    description: String = "",
    id: Graphql.ID = "",
    linkedTo: [Mock<Article>?]? = nil,
    publishedAt: String = "",
    source: GraphQLEnum<Graphql.Source> = .case(.tagesschau),
    title: String = "",
    uri: String = "",
    views: Int = 0
  ) {
    self.init()
    _setScalar(banner, for: \.banner)
    _setScalarList(category, for: \.category)
    _setScalar(description, for: \.description)
    _setScalar(id, for: \.id)
    _setList(linkedTo, for: \.linkedTo)
    _setScalar(publishedAt, for: \.publishedAt)
    _setScalar(source, for: \.source)
    _setScalar(title, for: \.title)
    _setScalar(uri, for: \.uri)
    _setScalar(views, for: \.views)
  }
}
