//
//  TabBarViewController.swift
//  Spotify
//
//  Created by jack on 2025/10/29.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isTranslucent = true
        self.tabBar.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        let home = HomeViewController()
        let search = SearchViewController()
        let library = LibraryViewController()
        
        home.title = "首页"
        search.title = "搜索"
        library.title = "歌单"
        
        
        home.navigationItem.largeTitleDisplayMode = .always;
        search.navigationItem.largeTitleDisplayMode = .always;
        library.navigationItem.largeTitleDisplayMode = .always;
        
        
        
        let homeNav = UINavigationController(rootViewController: home)
        let searchNav = UINavigationController(rootViewController: search)
        let libraryNav = UINavigationController(rootViewController: library)
        
        homeNav.tabBarItem = UITabBarItem(title:home.title, image: UIImage(systemName: "house"), tag: 1)
        searchNav.tabBarItem = UITabBarItem(title: "搜索", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        libraryNav.tabBarItem = UITabBarItem(title: "歌单", image: UIImage(systemName: "music.note.list"), tag: 3)
      
//        homeNav.navigationBar.prefersLargeTitles = true
//        searchNav.navigationBar.prefersLargeTitles = true
//        libraryNav.navigationBar.prefersLargeTitles = true
        
   
        setViewControllers([homeNav,searchNav,libraryNav], animated: false)
        
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

struct TabBarViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ContainerView()
            .edgesIgnoringSafeArea(.all) // 让预览铺满
    }
}

struct ContainerView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> TabBarViewController {
        return TabBarViewController()
    }
    
    func updateUIViewController(_ uiViewController: TabBarViewController, context: Context) {
        // 通常不需要更新逻辑
//        uiViewController.view.setNeedsLayout()
//               uiViewController.view.layoutIfNeeded()
    }
}
