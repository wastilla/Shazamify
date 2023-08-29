//
//  AuthWebView.swift
//  Shazamy
//
//  Created by will astilla on 8/14/23.
//

import SwiftUI
import Combine
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
            
            @AppStorage("userCode") var code: String = ""
        
            private var cancellables = Set<AnyCancellable>()

            init(_ parent: AuthWebView) {
                self.parent = parent
            }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation naviagation: WKNavigation!){
            let component = URLComponents(string: webView.url!.absoluteString)
                guard let code = component?.queryItems?.first(where: { $0.name == "code"})?.value else {
                    print("NO CODE")
                    return
                }
            self.code = code
            AuthManager.shared.exchangeCodeForToken(code: code)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("FAIL")
                        print(error)
                    }
                }, receiveValue: { token in
                    // successful request
                    print("TOKEN: \(token)")
                    // publish the data
                    
                }).store(in: &self.cancellables)
                
            }
        }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}
