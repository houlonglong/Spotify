//
//  AuthManager.swift
//  Spotify
//
//  Created by jack on 2025/10/29.
// token:AQCoRVL07Ot6rQBPfFtc5SlBCi1ZgVdwqPw5Qc8iol8qNf2lDarMX8UPBCAWGjVURxwVEQaai5-fytOt4z9sdjdb-GZueEj0-5lUE1tXJyBqN1U4P6ECLqJBs8X6YphrxbvTeR8qnTDd5ALoh3n0VGiqHKuPKsJaW5t43D7FQdHD_TfcfPkHTFe4jiLbmFDbXQ
import Foundation
import Alamofire

// 最终类，用于管理用户认证相关逻辑，采用单例模式
final class AuthManager {
    // 单例实例，全局唯一访问点
    static let shared = AuthManager()
    

    struct Constants {
       static let clientID = "8bee83f1304a435e96d229f7d2509acb"
       static let client_secret = "cd82193968c84bfeac90005b1b88cf05"
       static let tokenUrl = "https://accounts.spotify.com/api/token"
       static  let redirectURI = "https://www.iosacademy.io/"
    }
    
    public var signInURL: URL? {
        // 定义Spotify认证所需的权限范围，这里是读取用户私有信息的权限
        let scopes = "user-read-private"
        // 认证成功后的重定向URL
        // Spotify账号服务的授权基础URL
        let base = "https://accounts.spotify.com/authorize"
        // 拼接完整的授权URL字符串，包含响应类型、客户端ID、权限范围和重定向URL
        let string = "\(base)?response_type=code&client_id=\(Constants.clientID)&scope=\(scopes)&redirect_uri=\(Constants.redirectURI)&show_diolog=TRUE"
        // 将字符串转换为URL并返回
        return URL(string: string)
    }
    
    // 私有初始化方法，防止外部创建实例，确保单例模式
    private init() {}
    
    // 标记用户是否已登录
    var isSignedIn: Bool {
        return false
    }
    
    // 访问令牌，用于API认证，私有属性
    private var accessToken: String? {
        return nil
    }
    
    // 刷新令牌，用于在访问令牌过期时获取新的访问令牌，私有属性
    private var refreshToken: String? {
        return nil
    }
    
    // 令牌过期日期，用于判断访问令牌是否过期，私有属性
    private var tokenExpirationDate: Date? {
        return nil
    }
    
    // 判断是否需要刷新令牌，私有属性
    private var shouldRefreshToken: Bool {
        return false
    }
    /// 使用授权码向服务器请求访问令牌（Token）
    public func exchangeCodeForToken(code: String) async -> Bool {
        let parameters: [String: String] = [
            "grant_type": "authorization_code",
            "redirect_uri": Constants.redirectURI,
            "code": code
        ]
        
        let basicToken = "\(Constants.clientID):\(Constants.client_secret)"
        guard let data = basicToken.data(using: .utf8) else { return false }
        let base64String = data.base64EncodedString()
        
        let headers: HTTPHeaders = [
            "Authorization": "Basic \(base64String)",
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        do {
            // Task.detached 在后台线程执行，避免 MainActor 隔离
            let tokenResponse = try await Task.detached(priority: .background) {
                try await AF.request(
                    Constants.tokenUrl,
                    method: .post,
                    parameters: parameters,
                    encoder: URLEncodedFormParameterEncoder.default,
                    headers: headers
                )
                .validate()
                .serializingDecodable(TokenResponse.self)
                .value
            }.value
            
            print("✅ 获取 Token: \(tokenResponse)")
            return true
        } catch {
            print("❌ 获取 Token 失败: \(error.localizedDescription)")
            return false
        }
    }
    
    
    

    /// 缓存（保存）从服务器获取到的访问令牌（Token）
    public func cacheToken() {
    }
    
    public func refreshAccessToken() {
    }
}



nonisolated struct TokenResponse: Decodable {
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
