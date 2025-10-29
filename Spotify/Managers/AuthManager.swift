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
