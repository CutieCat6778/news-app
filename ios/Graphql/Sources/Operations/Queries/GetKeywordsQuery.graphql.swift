// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
@_spi(Execution) @_spi(Unsafe) import ApolloAPI

public struct GetKeywordsQuery: GraphQLQuery {
  public static let operationName: String = "GetKeywords"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetKeywords { keywords { __typename ...ResponseKeywordFields } }"#,
      fragments: [ArticleFields.self, ResponseKeywordFields.self]
    ))

  public init() {}

  public struct Data: Graphql.SelectionSet {
    @_spi(Unsafe) public let __data: DataDict
    @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

    @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { Graphql.Objects.Query }
    @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
      .field("keywords", [Keyword?].self),
    ] }
    @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
      GetKeywordsQuery.Data.self
    ] }

    public var keywords: [Keyword?] { __data["keywords"] }

    public init(
      keywords: [Keyword?]
    ) {
      self.init(unsafelyWithData: [
        "__typename": Graphql.Objects.Query.typename,
        "keywords": keywords._fieldData,
      ])
    }

    /// Keyword
    ///
    /// Parent Type: `ResponseKeyWords`
    public struct Keyword: Graphql.SelectionSet {
      @_spi(Unsafe) public let __data: DataDict
      @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

      @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { Graphql.Objects.ResponseKeyWords }
      @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(ResponseKeywordFields.self),
      ] }
      @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        GetKeywordsQuery.Data.Keyword.self,
        ResponseKeywordFields.self
      ] }

      public var id: Graphql.ID { __data["id"] }
      public var keyword: String { __data["keyword"] }
      public var lastUpdate: String { __data["lastUpdate"] }
      public var articles: [Article?] { __data["articles"] }

      public struct Fragments: FragmentContainer {
        @_spi(Unsafe) public let __data: DataDict
        @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

        public var responseKeywordFields: ResponseKeywordFields { _toFragment() }
      }

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

      public typealias Article = ResponseKeywordFields.Article
    }
  }
}
