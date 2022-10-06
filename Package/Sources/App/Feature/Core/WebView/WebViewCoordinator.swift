//
//  WebViewCoordinator.swift
//
//
//  Created by yoshi on 2022/10/03.
//

import Foundation
import SwiftUI
import WebKit

class WebViewCoordinator: NSObject {

    @ObservedObject private var viewModel: WebViewModel

    init(viewModel: WebViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: WKNavigationDelegate

extension WebViewCoordinator: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        viewModel.current(url: webView.url)
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        viewModel.handleError(error)
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        viewModel.handleError(error)
    }
}

// MARK: WKUIDelegate

extension WebViewCoordinator: WKUIDelegate {

    func webView(
        _ webView: WKWebView,
        createWebViewWith configuration: WKWebViewConfiguration,
        for navigationAction: WKNavigationAction,
        windowFeatures: WKWindowFeatures
    ) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }

    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: (WKNavigationActionPolicy) -> Void
    ) {
        if let url = navigationAction.request.url?.absoluteString {
            if url.hasPrefix("https://apps.apple.com/") {
                guard let appStoreLink = URL(string: url) else {
                    return
                }
                UIApplication.shared.open(appStoreLink, options: [:]) { _ in
                }
                decisionHandler(WKNavigationActionPolicy.cancel)
            } else if url.hasPrefix("http") {
                decisionHandler(WKNavigationActionPolicy.allow)
            } else {
                decisionHandler(WKNavigationActionPolicy.cancel)
            }
        }
    }
}
