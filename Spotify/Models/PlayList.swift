import Foundation

// MARK: - PlayList
struct PlayList: Codable {
    var href: String?
    var limit: Int?
    var next: String?       // JSON null -> String?
    var offset: Int?
    var previous: String?   // JSON null -> String?
    var total: Int?
    var items: [PlayListItem]?
}

// MARK: - PlayListItem
struct PlayListItem: Codable {
    var collaborative: Bool?
    var description: String?
    var externalUrls: ExternalUrls?
    var href: String?
    var id: String?
    var images: [ApiImage]?
    var name: String?
    var owner: Owner?
    var primaryColor: String?   // JSON null -> String?
    var itemPublic: Bool?
    var snapshotID: String?
    var tracks: Tracks?
    var type: String?
    var uri: String?
}

// MARK: - Owner
struct Owner: Codable {
    var displayName: String?
    var externalUrls: ExternalUrls?
    var href: String?
    var id: String?
    var type: String?
    var uri: String?
}

// MARK: - Tracks
struct Tracks: Codable {
    var href: String?
    var total: Int?
}

