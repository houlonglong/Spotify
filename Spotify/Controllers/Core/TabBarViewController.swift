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
        
        
        let homeNav = UINavigationController(rootViewController: home);
        let searchNav = UINavigationController(rootViewController: search);
        let libraryNav = UINavigationController(rootViewController: library);
      
//        homeNav.navigationBar.prefersLargeTitles = true
//        searchNav.navigationBar.prefersLargeTitles = true
//        libraryNav.navigationBar.prefersLargeTitles = true
        
        homeNav.tabBarItem =  UITabBarItem(title: home.title, image: UIImage(systemName: "house"),tag: 1)
        search.tabBarItem =  UITabBarItem(title:search.title, image: UIImage(systemName: "magnifyingglass"),tag: 2)
        library.tabBarItem =  UITabBarItem(title: library.title, image: UIImage(systemName: "music.note.list"),tag: 3)
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
