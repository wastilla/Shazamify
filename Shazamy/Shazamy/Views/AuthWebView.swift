//
//  AuthWebView.swift
//  Shazamy
//
//  Created by will astilla on 8/14/23.
//

//import Foundation
//import UIKit
//import WebKit
//import SwiftUI
//
//struct AuthWebView: UIViewRepresentable {
//    let url: URL
//
//    func makeUIView(context: Context) -> WKWebView {
//        let preferences = WKWebpagePreferences()
//        preferences.allowsContentJavaScript = true
//
//        let config = WKWebViewConfiguration()
//        config.defaultWebpagePreferences = preferences
//
//        let webview = WKWebView(frame: .infinite, configuration: config)
//        return webview
//    }
//
//    func updateUIView(_ webView: WKWebView, context: Context) {
//        let request = URLRequest(url: url)
//        webView.load(request)
//    }
//}

import SwiftUI
import WebKit

struct AuthWebView: UIViewRepresentable {
    let url: URL
    
    //    public var completionHandler: ((Bool) -> Void)
    
    
    func makeUIView(context: Context) -> WKWebView {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let webview = WKWebView(frame: .zero, configuration: config)
        return webview
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.navigationDelegate = context.coordinator
        webView.load(request)
    }
    
    
    
    class Coordinator: NSObject, WKNavigationDelegate {
            var parent: AuthWebView

            init(_ parent: AuthWebView) {
                self.parent = parent
            }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation naviagation: WKNavigation!){
                print("here")
            let component = URLComponents(string: webView.url!.absoluteString)
            print(webView.url?.absoluteString)
            print(component?.queryItems?.first?.name)
                guard let code = component?.queryItems?.first(where: { $0.name == "code"})?.value else {
                    return
                }
            
                print("code: \(code)")
            }
        }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}
