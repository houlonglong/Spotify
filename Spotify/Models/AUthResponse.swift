//
//  AUthResponse.swift
//  Spotify
//
//  Created by jack on 2025/10/30.
//

import Foundation






nonisolated struct AUthResponse: Codable {
    let refreshToken: String
    let scope: String
    let tokenType: String
    let accessToken: String
    let expiresIn: Int64
    
    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
        case scope
        case tokenType = "token_type"
        case accessToken = "access_token"
        case expiresIn = "expires_in"
    }
}
