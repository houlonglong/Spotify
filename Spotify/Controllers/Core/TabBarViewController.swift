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
        let home = HomeViewController()
        let search = SearchViewController()
        let library = LibraryViewController()
        home.navigationItem.largeTitleDisplayMode = .always;
        search.navigationItem.largeTitleDisplayMode = .always;
        library.navigationItem.largeTitleDisplayMode = .always;
        let homeNav = UINavigationController(rootViewController: home);
        let searchNav = UINavigationController(rootViewController: search);
        let libraryNav = UINavigationController(rootViewController: library);
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
