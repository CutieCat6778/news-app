// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
@_spi(Execution) @_spi(Unsafe) import ApolloAPI

public struct ArticleWithLinks: Graphql.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment ArticleWithLinks on Article { __typename ...ArticleFields linkedTo { __typename id title source publishedAt banner } }"#
  }

  @_spi(Unsafe) public let __data: DataDict
  @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

  @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { Graphql.Objects.Article }
  @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("linkedTo", [LinkedTo?]?.self),
    .fragment(ArticleFields.self),
  ] }
  @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
    ArticleWithLinks.self,
    ArticleFields.self
  ] }

  public var linkedTo: [LinkedTo?]? { __data["linkedTo"] }
  public var id: Graphql.ID { __data["id"] }
  public var title: String { __data["title"] }
  public var source: GraphQLEnum<Graphql.Source> { __data["source"] }
  public var publishedAt: String { __data["publishedAt"] }
  public var uri: String { __data["uri"] }
  public var views: Int { __data["views"] }
  public var description: String { __data["description"] }
  public var banner: String { __data["banner"] }
  public var category: [String?]? { __data["category"] }

  public struct Fragments: FragmentContainer {
    @_spi(Unsafe) public let __data: DataDict
    @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

    public var articleFields: ArticleFields { _toFragment() }
  }

  public init(
    linkedTo: [LinkedTo?]? = nil,
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
      "linkedTo": linkedTo._fieldData,
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

  /// LinkedTo
  ///
  /// Parent Type: `Article`
  public struct LinkedTo: Graphql.SelectionSet {
    @_spi(Unsafe) public let __data: DataDict
    @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

    @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { Graphql.Objects.Article }
    @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("id", Graphql.ID.self),
      .field("title", String.self),
      .field("source", GraphQLEnum<Graphql.Source>.self),
      .field("publishedAt", String.self),
      .field("banner", String.self),
    ] }
    @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
      ArticleWithLinks.LinkedTo.self
    ] }

    public var id: Graphql.ID { __data["id"] }
    public var title: String { __data["title"] }
    public var source: GraphQLEnum<Graphql.Source> { __data["source"] }
    public var publishedAt: String { __data["publishedAt"] }
    public var banner: String { __data["banner"] }

    public init(
      id: Graphql.ID,
      title: String,
      source: GraphQLEnum<Graphql.Source>,
      publishedAt: String,
      banner: String
    ) {
      self.init(unsafelyWithData: [
        "__typename": Graphql.Objects.Article.typename,
        "id": id,
        "title": title,
        "source": source,
        "publishedAt": publishedAt,
        "banner": banner,
      ])
    }
  }
}
