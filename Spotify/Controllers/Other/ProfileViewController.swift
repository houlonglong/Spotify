//
//  ProfileViewController.swift
//  Spotify
//
//  Created by jack on 2025/10/29.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        hidesBottomBarWhenPushed = true
        view.backgroundColor = .red
        title = "321321"
        Task {
            do {
                let profile = try await APICaller.shared.getCurrentUserProfile()
                print("✅ 用户名:", profile.displayName)
            } catch {
                print("❌ 获取用户信息失败:", error.localizedDescription)
            }
        }
    }
   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
