

import Foundation
import SwiftUI
import WebKit

struct WebView : UIViewRepresentable {
    
    let request: URLRequest
    var webview: WKWebView?
    var didFinishHandle: (()->Void)?
    var dowloadDocument: ((Bool)->Void)?
    var handleMission: ((Int)->Void)?
    var handlePractice: (()->Void)?
    var handleOpenExerciseHistory: (()->Void)?
    var showUserManualMenu: (()->Void)?
    
    init(request: URLRequest) {
        self.webview = WKWebView()
        self.request = request
    }
    
    class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        // Delegate methods go here
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.didFinishHandle?()
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            print("didFail navigation")
        }
        
        func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
            print("webViewWebContentProcessDidTerminate")
            webView.reload()
        }
        
        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
       
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView  {
        let contentControler = WKUserContentController()
        contentControler.add(makeCoordinator(), name: "webclient")
        let config = WKWebViewConfiguration()
        config.userContentController = contentControler
        config.allowsInlineMediaPlayback = true
        let webview = WKWebView(frame: .zero, configuration: config)
        webview.uiDelegate = context.coordinator
        webview.navigationDelegate = context.coordinator
        webview.reloadFromOrigin()
        return webview
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.uiDelegate = context.coordinator
        uiView.load(request)
    }
    
    func goBack(){
        webview?.goBack()
    }
    
    func goForward(){
        webview?.goForward()
    }
    
    func reload(){
        webview?.reload()
    }
    
    func didFinish(completed: (()->Void)?) -> WebView {
        var instance = self
        instance.didFinishHandle = completed
        return instance
    }
    
    func handleMission(completed: ((Int)->Void)?) -> WebView {
        var instance = self
        instance.handleMission = completed
        return instance
    }
    
    func handlePractice(completed: (()->Void)?) -> WebView {
        var instance = self
        instance.handlePractice = completed
        return instance
    }
    
    func handleOpenExerciseHistory(completed: (()->Void)?) -> WebView {
        var instance = self
        instance.handleOpenExerciseHistory = completed
        return instance
    }
    
    func showUserManualMenu(completed: (()->Void)?) -> WebView {
        var instance = self
        instance.showUserManualMenu = completed
        return instance
    }
    
    func dowloadDocument(completed: ((Bool)->Void)?) -> WebView {
        var instance = self
        instance.dowloadDocument = completed
        return instance
    }
}
