//
//  APICaller.swift
//  Spotify
//
//  Created by jack on 2025/10/29.
//

import Foundation
import Alamofire

final class APICaller {
    static let shared = APICaller()
    private init() {}
    
    let baseAPIURL = "https://api.spotify.com/v1"
    
    func getCurrentUserProfile() async throws -> UserProfile {
        let token = try await AuthManager.shared.withValidToken()
        let url = URL(string: "\(baseAPIURL)/me")!
        let request = AF.request(url, method: .get, headers: ["Authorization": "Bearer \(token)"])
        
        let profile = try await request
            .validate()
            .serializingDecodable(UserProfile.self)
            .value
        
        
        return profile
    }
}
