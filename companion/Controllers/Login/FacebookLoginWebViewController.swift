//
//  FacebookLoginWebViewController.swift
//  companion
//
//  Created by Uchenna  Aguocha on 10/25/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import KeychainSwift


class FacebookLoginWebViewController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - UI Elements
    
    lazy var facebookWebView: WKWebView = {
        
        let configuration = WKWebViewConfiguration()
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        return webView
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(cancelFacebookLogin), for: .touchUpInside)
        return button
    }()
    

    // MARK: - View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "https://www.makeschool.com/users/auth/facebook"
        let request = URLRequest(url: URL(string: url)!)
        facebookWebView.load(request)
        
        setupAutoLayout()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        let url = "https://www.makeschool.com/users/auth/facebook"
//        let request = URLRequest(url: URL(string: url)!)
//        facebookWebView.load(request)
//    }
    
    override func loadView() {
        super.loadView()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        view.backgroundColor = UIColor.white
    }
    
    // MARK: - Methods
    
    private func setupAutoLayout() {
     
        view.addSubview(facebookWebView)
        facebookWebView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            bottom: view.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            topPadding: 0,
            rightPadding: 0,
            bottomPadding: 0,
            leftPadding: 0,
            height: 0,
            width: 0)
        
        facebookWebView.addSubview(cancelButton)
        cancelButton.anchor(
            top: facebookWebView.topAnchor,
            right: nil,
            bottom: nil,
            left: facebookWebView.leftAnchor,
            topPadding: 7,
            rightPadding: 0,
            bottomPadding: 0,
            leftPadding: 5,
            height: 25,
            width: 70)
        
    }
    
    @objc private func cancelFacebookLogin() {
        print("Cancelling Facebook Login")
        self.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - WKUIDelegate Methods

extension FacebookLoginWebViewController: WKUIDelegate {
    
    func webViewDidClose(_ webView: WKWebView) {
        print("Dismiss webView")
    }
    
}


// MARK: - WKNavigationDelegate Methods

extension FacebookLoginWebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let keychain = KeychainSwift()
        if (navigationAction.navigationType == .linkActivated){
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
            let url = navigationAction.request.url?.absoluteURL
            //handle your events from here
            if url == URL(string: "https://www.makeschool.com/dashboard#_=_") {
                _ = WKWebsiteDataStore.default().httpCookieStore.getAllCookies { (cookies) in
                    
                    // Concurrently iterating through the cookies to find specific make school session so that we can grab the make school users object
                    DispatchQueue.concurrentPerform(iterations: cookies.count, execute: { (cookieIndex) in // How I see this working slower is that if the cookie we are looking for is the first cookie becuase then it is more work to spin the threads up and then check the first cookie then it is to do a lineasr iteration and find it in the first index
                        let cookie = cookies[cookieIndex]
                        if cookie.domain == "www.makeschool.com" && cookie.name == "_makeschool_session"{
                            // Setting the cookie value for the session in keychain
                            keychain.set(cookie.value, forKey: "cookieValue")
                            keychain.set(cookie.domain, forKey: "cookieDomain")
                            keychain.set(cookie.name, forKey: "cookieName")
                            //HTTPCookieStorage.shared.setCookie(cookie)
                            
                            FacebookServices.showFacebookUserProfile(completionHandler: { (user, error) in
                                if let user = user{
                                    User.setCurrent(user, writeToUserDefaults: true)
                                    // go to the next view controller
                                
                                    let mainTabBarController = MainTabBarController()
                                    self.present(mainTabBarController, animated: true, completion: nil)
                                }
                            })
                            return
                        }
                    })
                }
            }
        }
        
    }
}

