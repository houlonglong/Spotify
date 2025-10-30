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
        
        let profileVc = ProfileViewController()
        profileVc.hidesBottomBarWhenPushed = true 
        navigationItem.backButtonTitle = ""
        self.navigationController?.pushViewController(profileVc, animated: true)
      
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        hidesBottomBarWhenPushed = false
    }
}

