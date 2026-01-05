// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
@_spi(Execution) @_spi(Unsafe) import ApolloAPI

public struct KeywordFields: Graphql.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment KeywordFields on KeyWords { __typename keyword lastUpdate }"#
  }

  @_spi(Unsafe) public let __data: DataDict
  @_spi(Unsafe) public init(_dataDict: DataDict) { __data = _dataDict }

  @_spi(Execution) public static var __parentType: any ApolloAPI.ParentType { Graphql.Objects.KeyWords }
  @_spi(Execution) public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("keyword", String.self),
    .field("lastUpdate", String.self),
  ] }
  @_spi(Execution) public static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
    KeywordFields.self
  ] }

  public var keyword: String { __data["keyword"] }
  public var lastUpdate: String { __data["lastUpdate"] }

  public init(
    keyword: String,
    lastUpdate: String
  ) {
    self.init(unsafelyWithData: [
      "__typename": Graphql.Objects.KeyWords.typename,
      "keyword": keyword,
      "lastUpdate": lastUpdate,
    ])
  }
}
