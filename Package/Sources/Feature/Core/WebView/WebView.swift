//
//  WebView.swift
//
//
//  Created by Yoshiki Hemmi on 2022/10/01.
//

import Foundation
import SwiftUI
import WebKit

struct WebView { // swiftlint:disable:this file_types_order
    @ObservedObject private var viewState: WebViewStateModel

    init(viewState: WebViewStateModel) {
        self.viewState = viewState
    }
}

// MARK: UIViewRepresentable

extension WebView: UIViewRepresentable { // swiftlint:disable:this file_types_order
    typealias Coordinator = WebViewCoordinator

    func makeCoordinator() -> Coordinator {
        WebViewCoordinator(viewState: viewState)
    }

    func makeUIView(context: Context) -> WKWebView {
        guard let url = viewState.url else {
            return WKWebView()
        }

        let wkWebView = WKWebView()
        let request = URLRequest(url: url)

        wkWebView.navigationDelegate = context.coordinator
        wkWebView.uiDelegate = context.coordinator
        wkWebView.load(request)
        viewState.subscribe(wkWebView: wkWebView)

        return wkWebView
    }

    func updateUIView(_ wkWebView: WKWebView, context: Context) {
        Task { @MainActor in
            if viewState.shouldGoBack {
                _ = wkWebView.goBack()
                viewState.shouldGoBack = false
            }

            if viewState.shouldGoForward {
                _ = wkWebView.goForward()
                viewState.shouldGoForward = false
            }

            if viewState.shouldLoad {
                guard let url = viewState.url else {
                    return
                }

                let request = URLRequest(url: url)
                _ = wkWebView.load(request)
                viewState.shouldLoad = false
            }
        }
    }
}

// MARK: Coordinator

class WebViewCoordinator: NSObject {

    @ObservedObject private var viewState: WebViewStateModel

    init(viewState: WebViewStateModel) {
        self.viewState = viewState
    }
}

// MARK: WKNavigationDelegate

extension WebViewCoordinator: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        viewState.isLoading = true
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        viewState.isLoading = false
        viewState.current(url: webView.url)
        viewState.canGoBack = webView.canGoBack
        viewState.canGoForward = webView.canGoForward
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        viewState.isLoading = false
        setError(error)
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        viewState.isLoading = false
        setError(error)
    }

    func setError(_ error: Error) {
        if let error = error as? URLError {
            viewState.error = WebViewError(code: error.code, message: error.localizedDescription)
        }
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
