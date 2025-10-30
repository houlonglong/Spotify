//
//  AuthViewController.swift
//  Spotify
//
//  Created by jack on 2025/10/29.
//

import UIKit
import WebKit

class AuthViewController: UIViewController, WKNavigationDelegate {
    
    private var continuation: CheckedContinuation<Bool?, Never>?
    private var webView: WKWebView!
    var onAuthorizationCompleted: ((Bool) -> Void)?
    
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
        guard let url = AuthManager.shared.signInURL else {
            return
        }
        webview.load(URLRequest(url: url))
        // Do any additional setup after loading the view.
    }
    
    
     func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url,
           let code = URLComponents(string: url.absoluteString)?
                        .queryItems?.first(where: { $0.name == "code" })?.value {

//          webView.isHidden = true
            decisionHandler(.cancel)

            Task {
                let success = await AuthManager.shared.exchangeCodeForToken(code: code)
                onAuthorizationCompleted?(true)
               
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
         
            return
        }

        decisionHandler(.allow)
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
