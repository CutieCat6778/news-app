// swift-tools-version:6.1

import PackageDescription

let package = Package(
  name: "Graphql",
  platforms: [
    .iOS(.v15),
    .macOS(.v12),
    .tvOS(.v15),
    .watchOS(.v8),
    .visionOS(.v1),
  ],
  products: [
    .library(name: "Graphql", targets: ["Graphql"]),
    .library(name: "GraphqlTestMocks", targets: ["GraphqlTestMocks"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apollographql/apollo-ios", exact: "2.0.4"),
  ],
  targets: [
    .target(
      name: "Graphql",
      dependencies: [
        .product(name: "ApolloAPI", package: "apollo-ios"),
      ],
      path: "./Sources"
    ),
    .target(
      name: "GraphqlTestMocks",
      dependencies: [
        .product(name: "ApolloTestSupport", package: "apollo-ios"),
        .target(name: "Graphql"),
      ],
      path: "./GraphqlTestMocks"
    ),
  ],
  swiftLanguageModes: [.v6, .v5]
)
