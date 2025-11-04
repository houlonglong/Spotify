// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let following = try Following(json)

import Foundation

// MARK: - Following
struct Following: Codable {
    var artists: Artists?
}

// MARK: - Artists
struct Artists: Codable {
    var href: String?
    var limit: Int?
    var next: String?       // ✅ Change from NSNull? to String? — JSON null is handled automatically by Codable
    var cursors: Cursors?
    var total: Int?
    var items: [FollowingItem]?
}

// MARK: - Cursors
struct Cursors: Codable {
    var after: String?      // ✅ Same — should be String?, not NSNull?
}

// MARK: - FollowingItem
struct FollowingItem: Codable {
    var external_urls: ExternalUrls?
    var followers: Followers?
    var genres: [String]?
    var href: String?
    var id: String?
    var images: [ApiImage]?
    var name: String?
    var popularity: Int?
    var type: String?
    var uri: String?
}

// MARK: - ExternalUrls


// MARK: - Followers



