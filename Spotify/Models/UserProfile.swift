//
//  UserProfile.swift
//  Spotify
//
//  Created by jack on 2025/10/29.
//

import Foundation


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let userProfile = try? JSONDecoder().decode(UserProfile.self, from: jsonData)

import Foundation

// MARK: - UserProfile
nonisolated struct UserProfile: Codable {
    let country:String?
    let displayName: String
    let explicitContent: ExplicitContent?
    let externalUrls: ExternalUrls?
    let followers: Followers?
    let href: String?
    let id: String?
    let images: [Image]?
    let product, type, uri: String

    enum CodingKeys: String, CodingKey {
        case country
        case displayName = "display_name"
        case explicitContent = "explicit_content"
        case externalUrls = "external_urls"
        case followers, href, id, images, product, type, uri
    }

    // MARK: - 静态 Mock 数据
    static let mockData: [String: Any] = [
        "country": "JP",
        "display_name": "月亮多会来",
        "explicit_content": ["filter_enabled": false, "filter_locked": false],
        "external_urls": ["spotify": "https://open.spotify.com/user/31mlpqc4r66ewc6vz4qp4g7bqu6m"],
        "followers": ["href": NSNull(), "total": 123],
        "href": "https://api.spotify.com/v1/users/31mlpqc4r66ewc6vz4qp4g7bqu6m",
        "id": "31mlpqc4r66ewc6vz4qp4g7bqu6m",
        "images": [
            ["height": 300, "url": "https://i.scdn.co/image/ab6775700000ee856222536b819420ac2735e7f9", "width": 300],
            ["height": 64, "url": "https://i.scdn.co/image/ab67757000003b826222536b819420ac2735e7f9", "width": 64]
        ],
        "product": "free",
        "type": "user",
        "uri": "spotify:user:31mlpqc4r66ewc6vz4qp4g7bqu6m"
    ]

    // MARK: - 静态解析方法
    static func parseMockData() -> UserProfile? {
        do {
          
            let jsonData = try JSONSerialization.data(withJSONObject: mockData, options: [])
           

            // 2️⃣ 直接解码成 UserProfile
           
//            print([jsonData,1111])
             let decoder = JSONDecoder()
//            print([decoder,2222222])
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let profile = try decoder.decode(UserProfile.self, from: jsonData)
            return profile
        } catch {
            print("❌ 解析 mock 数据失败:", error.localizedDescription)
            return nil
        }
    }
}

// MARK: - ExplicitContent
struct ExplicitContent: Codable {
    let filterEnabled, filterLocked: Bool

    enum CodingKeys: String, CodingKey {
        case filterEnabled = "filter_enabled"
        case filterLocked = "filter_locked"
    }
}

// MARK: - ExternalUrls
struct ExternalUrls: Codable {
    let spotify: String
}

// MARK: - Followers
struct Followers: Codable {
    let href: JSONNull?
    let total: Int
}

// MARK: - Image
struct Image: Codable {
    let height: Int
    let url: String
    let width: Int
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
    }

    public var hashValue: Int {
            return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                    throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
    }

    public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
    }
}

 
