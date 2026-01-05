import Apollo
import Foundation

class Network {
    static let shared = Network()

    let apollo: ApolloClient

    init() {
        apollo = ApolloClient(url: URL(string: "http://localhost:3000/query")!)
    }
}
