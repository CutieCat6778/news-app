// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
@testable import Graphql

public final class ResponseKeyWords: MockObject {
  public static let objectType: ApolloAPI.Object = Graphql.Objects.ResponseKeyWords
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<ResponseKeyWords>>

  public struct MockFields: Sendable {
    @Field<[Article?]>("articles") public var articles
    @Field<Graphql.ID>("id") public var id
    @Field<String>("keyword") public var keyword
    @Field<String>("lastUpdate") public var lastUpdate
  }
}

public extension Mock where O == ResponseKeyWords {
  convenience init(
    articles: [Mock<Article>?] = [],
    id: Graphql.ID = "",
    keyword: String = "",
    lastUpdate: String = ""
  ) {
    self.init()
    _setList(articles, for: \.articles)
    _setScalar(id, for: \.id)
    _setScalar(keyword, for: \.keyword)
    _setScalar(lastUpdate, for: \.lastUpdate)
  }
}
