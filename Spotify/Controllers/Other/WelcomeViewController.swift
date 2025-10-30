//
//  WelcomeViewController.swift
//  Spotify
//
//  Created by jack on 2025/10/29.
//

import UIKit

class WelcomeViewController: UIViewController {
    private let sigInButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("登陆Spotify", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Spotify"
        view.backgroundColor = .systemGreen
        view.addSubview(sigInButton)
        sigInButton.addTarget(self, action: #selector(didTapSigIn), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sigInButton.frame = CGRect(x:20,y: view.height - 50 - view.safeAreaInsets.bottom,width: view.width - 40,height: 50)
    }
    
    @objc func didTapSigIn() {
        let authVC = AuthViewController()
        authVC.navigationItem.largeTitleDisplayMode = .never

        // 设置回调，当授权完成时通知登录页面
        authVC.onAuthorizationCompleted = {  [weak self] success in
            self?.handleSigin(success:success)
            authVC.onAuthorizationCompleted = nil
        }
        

        navigationController?.pushViewController(authVC, animated: true)
      
    }
    
   
    private func handleSigin(success: Bool) {
        // 如果登录失败，则直接返回
        guard success else { return }

        // 登录成功，创建主应用的 TabBar 控制器
        let mainAppTabBarVC = TabBarViewController()
        
        // 设置为全屏展示模式
        mainAppTabBarVC.modalPresentationStyle = .fullScreen
        
        // 替换当前窗口的根控制器，实现直接跳转到主界面
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? UIWindowSceneDelegate,
           let window = sceneDelegate.window {
            window?.rootViewController = mainAppTabBarVC
            window?.makeKeyAndVisible()
        } else {
            // 如果无法替换根控制器，则使用 present 方式展示
            self.present(mainAppTabBarVC, animated: true, completion: nil)
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



import SwiftUI
struct WelcomeViewControllerPreview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let  webNav = UINavigationController(rootViewController: WelcomeViewController())
              webNav.navigationBar.prefersLargeTitles = true
              webNav.viewControllers.first?.navigationItem.largeTitleDisplayMode = .always;
           return  webNav
        }
        .edgesIgnoringSafeArea(.all)
    }
}
