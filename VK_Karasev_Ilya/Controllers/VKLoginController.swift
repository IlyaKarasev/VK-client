//
//  VKLoginController.swift
//  VK_Karasev_Ilya
//
//  Created by ILYA Karasev on 23/05/2019.
//  Copyright © 2019 Ilya Karasev. All rights reserved.
//

import UIKit
import WebKit
import SwiftKeychainWrapper

class VKLoginController: UIViewController {

    @IBOutlet var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "oauth.vk.com"
        components.path = "/authorize"
        components.queryItems = [
            URLQueryItem(name: "client_id", value: "6994728"),
            URLQueryItem(name: "scope", value: "270342"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "http://oauth.vk.com/blank.html"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.95"),
        ]
        
        let request = URLRequest(url: components.url!)
        
        webView.load(request)
    }
}

extension VKLoginController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url,
        url.path == "/blank.html",
        let fragment = url.fragment else { decisionHandler(.allow); return }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param [1]
                dict[key] = value
                return dict
        }
        print(params)
        
        guard let token = params["access_token"],
            let userIdString = params["user_id"],
            let userId = Int(userIdString) else {
                decisionHandler(.allow)
                return
        }
        
        KeychainWrapper.standard.set(token, forKey: "access_token")
        //Session.sessionInfo.token = token       //Сохраняем токен в наш синглтон
        Session.sessionInfo.userId = userId     //Сохраняем id пользователя в синглтон
        
        performSegue(withIdentifier: "Show Main Screen", sender: nil)   //После успешной авторизации пользователя выполняем переход на "главную" страницу
        
        // Реализуем запросы к API на соответствующих контроллерах
        
        decisionHandler(.cancel)
    }
    
}
