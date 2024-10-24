//
//  WebView.swift
//  VkontakteNetwork
//
//  Created by Nikita Krylov on 06.09.2024.
//

import Foundation
import SwiftUI
@preconcurrency import WebKit

struct WebView: UIViewRepresentable {
    
    @Binding var token: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "52545623"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "scope", value: "photos")
        ]
        let request = URLRequest(url: urlComponents.url!)
        webView.load(request)
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
    
    func makeCoordinator() -> WebViewCoordinator {
        WebViewCoordinator{ token in
            self.token = token
        }
    }
}

class WebViewCoordinator: NSObject, WKNavigationDelegate{
    
    var token: (String) -> ()
    
    init(token: @escaping (String) -> Void) {
        self.token = token
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse,
        decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment =
            url.fragment else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map{$0.components(separatedBy: "=")}
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
        if let accessToken = params["access_token"] {
            token(accessToken)
        }
        
        decisionHandler(.cancel)
    }
}
