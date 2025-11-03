//
//  Artist.swift
//  Spotify
//
//  Created by jack on 2025/10/29.
//

import Foundation

// MARK: - Artist
struct Artist: Codable {
    let externalUrls: ExternalUrls?
    let href: String?
    let id: String?
    let name: String?
    let type: ArtistType?
    let uri: String?

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case href, id, name, type, uri
    }
}

// MARK: - ArtistType
enum ArtistType: String, Codable {
    case artist
}

// MARK: - ExternalUrls
struct ExternalUrls: Codable {
    let spotify: String?
}
