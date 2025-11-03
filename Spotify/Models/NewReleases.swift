import Foundation

// MARK: - NewReleases
struct NewReleases: Codable {
    var albums: NewReleasesAlbums?
}

// MARK: - Albums
struct NewReleasesAlbums: Codable {
    var href: String?
    var items: [Item]?
    var limit: Int?
    var next: String?
    var offset: Int?
    var previous: String? // 改成 String?
    var total: Int?
}

// MARK: - Item
struct Item: Codable {
    var albumType: AlbumTypeEnum?
    var artists: [Artist]?
    var availableMarkets: [String]?
    var externalUrls: ExternalUrls?
    var href: String?
    var id: String?
    var images: [ApiImage]?
    var name: String?
    var releaseDate: String?
    var releaseDatePrecision: ReleaseDatePrecision?
    var totalTracks: Int?
    var type: AlbumTypeEnum?
    var uri: String?

    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case artists, availableMarkets = "available_markets", externalUrls = "external_urls"
        case href, id, images, name
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case totalTracks = "total_tracks"
        case type, uri
    }
}

enum AlbumTypeEnum: String, Codable {
    case album
    case single
}




enum ReleaseDatePrecision: String, Codable {
    case day
}
