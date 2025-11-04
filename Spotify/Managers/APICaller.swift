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
    
    enum APIError:Error {
        case fiileedToGetData
    }
    
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
    
    //获取最新发布歌曲信息
    public func getNewReleases() async throws -> NewReleases {
        let token = try await AuthManager.shared.withValidToken()
        let url = URL(string: "\(baseAPIURL)/browse/new-releases?limit=10")!
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        let request =  AF.request(url, method: .get, headers: headers)
        print(headers)
        let data = try await request
            .validate()
            .serializingData()
            .value

        let newReleases = try JSONDecoder().decode(NewReleases.self, from: data)
        return newReleases
    }
    
    
    //关注歌手的列表
    public func getfollowing() async throws -> Following {
        let token = try await AuthManager.shared.withValidToken()
        let url = URL(string: "\(baseAPIURL)/me/following?type=artist")!
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        let request =  AF.request(url, method: .get, headers: headers)
        print(headers)
        let data = try await request
            .validate()
            .serializingData()
            .value
        
        let following = try JSONDecoder().decode(Following.self, from: data)
        return following
    }
    
    
    //已经过期
    public func featuredPlaylists() async throws -> FeaturedPlaylists {
     
        let token = try await AuthManager.shared.withValidToken()
        let url = URL(string: "\(baseAPIURL)/browse/featured-playlists")!
        print(url)
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        let request = AF.request(url, method: .get, headers: headers)
 
        let data = try await request
            .validate()
            .serializingData()
            .value
        print("dsadda")
        do {
              let featuredPlaylists = try JSONDecoder().decode(FeaturedPlaylists.self, from: data)
               print("✅ 成功解码：", featuredPlaylists.message ?? "无 message")
               return featuredPlaylists
           } catch {
               print("❌ JSON 解析失败: \(error)")
               throw error
           }
     
    }
}
