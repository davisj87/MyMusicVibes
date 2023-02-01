//
//  AuthViewController.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/2/23.
//

import UIKit
import WebKit

class AuthViewController: UIViewController, WKNavigationDelegate {

    private let authViewModel = AuthViewModel()
    private let webview: WKWebView = {
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = preferences
        let webview = WKWebView(frame: .zero, configuration: config)
        return webview
    }()
    
    public var completionHandler:((Bool) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sign In"
        self.view.backgroundColor = .systemBackground
        self.webview.navigationDelegate = self
        self.view.addSubview(webview)
        
        let url = authViewModel.authEndpointURL
        
        webview.load(URLRequest(url: url))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.webview.frame = self.view.bounds
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else { return }
        
        guard let code = URLComponents(string: url.absoluteString)?.queryItems?.first(where: {$0.name == "code"})?.value else { return }
        self.webview.isHidden = true
        Task{
            do{
                try await self.authViewModel.getAndSaveAuthToken(authCode: code)
               // try await self.authViewModel.getAlbumSearch()
                self.dismiss(animated: true, completion: nil)
                self.completionHandler?(true)
            } catch {
                self.dismiss(animated: true, completion: nil)
                self.completionHandler?(false)
                print("request didnt work")
            }
        }
    }
    
}
