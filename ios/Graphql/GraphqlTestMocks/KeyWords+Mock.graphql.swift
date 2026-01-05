// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
@testable import Graphql

public final class KeyWords: MockObject {
  public static let objectType: ApolloAPI.Object = Graphql.Objects.KeyWords
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<KeyWords>>

  public struct MockFields: Sendable {
    @Field<String>("keyword") public var keyword
    @Field<String>("lastUpdate") public var lastUpdate
  }
}

public extension Mock where O == KeyWords {
  convenience init(
    keyword: String = "",
    lastUpdate: String = ""
  ) {
    self.init()
    _setScalar(keyword, for: \.keyword)
    _setScalar(lastUpdate, for: \.lastUpdate)
  }
}
