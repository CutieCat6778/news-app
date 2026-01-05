// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
@_spi(Execution) @_spi(Unsafe) import ApolloAPI

public struct GetTopArticlesQuery: GraphQLQuery {
  public static let operationName: String = "GetTopArticles"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetTopArticles($amount: Int!) { topArticles(amount: $amount) { __typename ...ArticleFields } }"#,
      fragments: [ArticleFields.self]
    ))

  public var amount: Int32

  public init(amount: Int32) {
    self.amount = amount
  }

  @_spi(Unsafe) public var __variables: Variables? { ["amount": amount] }

  public struct Data: Graphql.SelectionSet {
    @_spi(Unsafe) public let __data: DataDict
    @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

    @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { Graphql.Objects.Query }
    @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
      .field("topArticles", [TopArticle?].self, arguments: ["amount": .variable("amount")]),
    ] }
    @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
      GetTopArticlesQuery.Data.self
    ] }

    public var topArticles: [TopArticle?] { __data["topArticles"] }

    public init(
      topArticles: [TopArticle?]
    ) {
      self.init(unsafelyWithData: [
        "__typename": Graphql.Objects.Query.typename,
        "topArticles": topArticles._fieldData,
      ])
    }

    /// TopArticle
    ///
    /// Parent Type: `Article`
    public struct TopArticle: Graphql.SelectionSet {
      @_spi(Unsafe) public let __data: DataDict
      @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

      @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { Graphql.Objects.Article }
      @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(ArticleFields.self),
      ] }
      @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        GetTopArticlesQuery.Data.TopArticle.self,
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
}
