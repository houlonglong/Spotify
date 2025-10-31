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
        title = "首页"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .prominent, target: self, action: #selector(didTapSttings))

    }
    @objc func didTapSttings() {
        
        let settingsVc = SettingsViewController()
        settingsVc.hidesBottomBarWhenPushed = true
        navigationItem.backButtonTitle = ""
        self.navigationController?.pushViewController(settingsVc, animated: true)
      
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        hidesBottomBarWhenPushed = false
    }
}


import SwiftUI
struct HomeViewControllerPreview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let  webNav = UINavigationController(rootViewController: HomeViewController())
//              webNav.navigationBar.prefersLargeTitles = true
//              webNav.viewControllers.first?.navigationItem.largeTitleDisplayMode = .always;
           return  webNav
        }
        .edgesIgnoringSafeArea(.all)
    }
}
