//
//  ViewController.swift
//  Spotify
//
//  Created by jack on 2025/10/29.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red

        Task {
            do {
                let profile = try await APICaller.shared.getCurrentUserProfile()
                print("✅ 用户名:", profile.displayName)
            } catch {
                print("❌ 获取用户信息失败:", error.localizedDescription)
            }
        }
    }


}

