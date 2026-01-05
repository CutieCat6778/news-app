// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
@_spi(Execution) @_spi(Unsafe) import ApolloAPI

public struct ArticleFields: Graphql.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment ArticleFields on Article { __typename id title source publishedAt uri views description banner category }"#
  }

  @_spi(Unsafe) public let __data: DataDict
  @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

  @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { Graphql.Objects.Article }
  @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("id", Graphql.ID.self),
    .field("title", String.self),
    .field("source", GraphQLEnum<Graphql.Source>.self),
    .field("publishedAt", String.self),
    .field("uri", String.self),
    .field("views", Int.self),
    .field("description", String.self),
    .field("banner", String.self),
    .field("category", [String?]?.self),
  ] }
  @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
    ArticleFields.self
  ] }

  public var id: Graphql.ID { __data["id"] }
  public var title: String { __data["title"] }
  public var source: GraphQLEnum<Graphql.Source> { __data["source"] }
  public var publishedAt: String { __data["publishedAt"] }
  public var uri: String { __data["uri"] }
  public var views: Int { __data["views"] }
  public var description: String { __data["description"] }
  public var banner: String { __data["banner"] }
  public var category: [String?]? { __data["category"] }

  public init(
    id: Graphql.ID,
    title: String,
    source: GraphQLEnum<Graphql.Source>,
    publishedAt: String,
    uri: String,
    views: Int,
    description: String,
    banner: String,
    category: [String?]? = nil
  ) {
    self.init(unsafelyWithData: [
      "__typename": Graphql.Objects.Article.typename,
      "id": id,
      "title": title,
      "source": source,
      "publishedAt": publishedAt,
      "uri": uri,
      "views": views,
      "description": description,
      "banner": banner,
      "category": category,
    ])
  }
}
