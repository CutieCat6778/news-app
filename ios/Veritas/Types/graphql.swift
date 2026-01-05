import SwiftUI

struct Article: Identifiable {
    let id: String
    let title: String
    let source: String
    let publishedAt: Date
    let uri: String
    let views: Int
    let description: String
    let banner: String
    let linkedTo: [Article]
    let category: [String]
}
