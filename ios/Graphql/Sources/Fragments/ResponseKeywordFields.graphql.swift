// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
@_spi(Execution) @_spi(Unsafe) import ApolloAPI

public struct ResponseKeywordFields: Graphql.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment ResponseKeywordFields on ResponseKeyWords { __typename id keyword lastUpdate articles { __typename ...ArticleFields } }"#
  }

  @_spi(Unsafe) public let __data: DataDict
  @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

  @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { Graphql.Objects.ResponseKeyWords }
  @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("id", Graphql.ID.self),
    .field("keyword", String.self),
    .field("lastUpdate", String.self),
    .field("articles", [Article?].self),
  ] }
  @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
    ResponseKeywordFields.self
  ] }

  public var id: Graphql.ID { __data["id"] }
  public var keyword: String { __data["keyword"] }
  public var lastUpdate: String { __data["lastUpdate"] }
  public var articles: [Article?] { __data["articles"] }

  public init(
    id: Graphql.ID,
    keyword: String,
    lastUpdate: String,
    articles: [Article?]
  ) {
    self.init(unsafelyWithData: [
      "__typename": Graphql.Objects.ResponseKeyWords.typename,
      "id": id,
      "keyword": keyword,
      "lastUpdate": lastUpdate,
      "articles": articles._fieldData,
    ])
  }

  /// Article
  ///
  /// Parent Type: `Article`
  public struct Article: Graphql.SelectionSet {
    @_spi(Unsafe) public let __data: DataDict
    @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

    @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { Graphql.Objects.Article }
    @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .fragment(ArticleFields.self),
    ] }
    @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
      ResponseKeywordFields.Article.self,
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

    public struct Fragments: FragmentContainer {
      @_spi(Unsafe) public let __data: DataDict
      @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

      public var articleFields: ArticleFields { _toFragment() }
    }

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
}
