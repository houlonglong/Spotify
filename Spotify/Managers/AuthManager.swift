//
//  AuthManager.swift
//  Spotify
//
//  Created by jack on 2025/10/29.
//
import Foundation

// 最终类，用于管理用户认证相关逻辑，采用单例模式
final class AuthManager {
    // 单例实例，全局唯一访问点
    static let shared = AuthManager()
    

    struct Constants {
       static let clientID = "8bee83f1304a435e96d229f7d2509acb"
       static let aa = "8bee83f1304a435e96d229f7d2509acb"
    }
    
    public var signInURL: URL? {
        // 定义Spotify认证所需的权限范围，这里是读取用户私有信息的权限
        let scopes = "user-read-private"
        // 认证成功后的重定向URL
        let redirectURI = "https://www.iosacademy.io/"
        // Spotify账号服务的授权基础URL
        let base = "https://accounts.spotify.com/authorize"
        // 拼接完整的授权URL字符串，包含响应类型、客户端ID、权限范围和重定向URL
        let string = "\(base)?response_type=code&client_id=\(Constants.clientID)&scope=\(scopes)&redirect_uri=\(redirectURI)&show_diolog=TRUE"
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
}
