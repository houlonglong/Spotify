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
        let vc = AuthViewController()
        vc.completionHandler = { [weak self] success in
            DispatchQueue.main.async {
                self?.handleSigin(success:success)
            }
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: false)
        
    }
    private func handleSigin(success:Bool) {
        print(success)
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
