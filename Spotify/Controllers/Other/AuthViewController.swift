//
//  AuthViewController.swift
//  Spotify
//
//  Created by jack on 2025/10/29.
//

import UIKit
import WebKit

class AuthViewController: UIViewController, WKNavigationDelegate {
    
    private let webview:WKWebView =  {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config  = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let webview = WKWebView(frame: .zero,configuration: config)
        return webview
    }()
    
    public var completionHandler:((Bool) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "登陆"
        webview.navigationDelegate = self
        view.addSubview(webview)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webview.frame = view.bounds
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
