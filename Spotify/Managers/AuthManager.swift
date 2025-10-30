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
       static let redirectURI = "https://www.iosacademy.io/"
       static let scopes="user-read-private%20playlist-modify-public%20playlist-read-private%20playlist-modify-private%20user-follow-read%20user-library-modify%20user-library-read%20user-read-email"
    }
    
    public var signInURL: URL? {
        // 定义Spotify认证所需的权限范围，这里是读取用户私有信息的权限
       
        // 认证成功后的重定向URL
        // Spotify账号服务的授权基础URL
        let base = "https://accounts.spotify.com/authorize"
        // 拼接完整的授权URL字符串，包含响应类型、客户端ID、权限范围和重定向URL
        let string = "\(base)?response_type=code&client_id=\(Constants.clientID)&scope=\(Constants.scopes)&redirect_uri=\(Constants.redirectURI)&show_diolog=TRUE"
        // 将字符串转换为URL并返回
        return URL(string: string)
    }
    
    // 私有初始化方法，防止外部创建实例，确保单例模式
    private init() {}
    
    // 标记用户是否已登录
    var isSignedIn: Bool {
        return accessToken != nil
    }
    
    // 访问令牌，用于API认证，私有属性
    private var accessToken: String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }
    
    // 刷新令牌，用于在访问令牌过期时获取新的访问令牌，私有属性
    private var refreshToken: String? {
        return UserDefaults.standard.string(forKey: "refresh_token")
    }
    
    // 令牌过期日期，用于判断访问令牌是否过期，私有属性
    private var tokenExpirationDate: Date? {
          return UserDefaults.standard.object(forKey: "expiresDate") as? Date
    }
    
    // 判断是否需要刷新令牌，私有属性
    private var shouldRefreshToken: Bool {
        guard let expiresDate = tokenExpirationDate else {
            return false
        }
        let currentDate = Date()
        let fiveMinutes:TimeInterval = 300
        return currentDate.addingTimeInterval(TimeInterval(fiveMinutes)) >= expiresDate
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
                .serializingDecodable(AUthResponse.self)
                .value
            }.value
            self.cacheToken(reslut: tokenResponse)
            return true
        } catch {
            print("❌ 获取 Token 失败: \(error.localizedDescription)")
            return false
        }
    }
    
    
    

    /// 缓存（保存）从服务器获取到的访问令牌（Token）
    public func cacheToken(reslut:AUthResponse) {
        UserDefaults.standard.setValue(reslut.accessToken, forKey: "access_token")
        if !reslut.refreshToken.isEmpty {
            UserDefaults.standard.setValue(reslut.refreshToken, forKey: "refresh_token")
        }
      
        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(reslut.expiresIn)), forKey: "expiresDate")
    }
    
    public func refreshIfNeeded(completion: @escaping (Bool) -> Void) {
        // 判断是否需要刷新
        guard shouldRefreshToken else {
            completion(false)
            return
        }
        
        // 必须有 refreshToken，否则无法刷新
        guard let refreshToken = self.refreshToken else {
            completion(false)
            return
        }
        
        let parameters: [String: String] = [
            "grant_type": "refresh_token",
            "refresh_token": refreshToken
        ]
        
        let basicToken = "\(Constants.clientID):\(Constants.client_secret)"
        guard let data = basicToken.data(using: .utf8) else {
            completion(false)
            return
        }
        let base64String = data.base64EncodedString()
        
        let headers: HTTPHeaders = [
            "Authorization": "Basic \(base64String)",
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        // 使用 Alamofire 异步请求，完成后通过闭包回调
        AF.request(
            Constants.tokenUrl,
            method: .post,
            parameters: parameters,
            encoder: URLEncodedFormParameterEncoder.default,
            headers: headers
        )
        .validate()
        .responseDecodable(of: AUthResponse.self) { [weak self] response in
            switch response.result {
            case .success(let tokenResponse):
                // 缓存新的 token
                self?.cacheToken(reslut: tokenResponse)
                completion(true)
            case .failure(let error):
                completion(false)
            }
        }
    }

}




