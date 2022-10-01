//
//  WebView.swift
//
//
//  Created by Yoshiki Hemmi on 2022/10/01.
//

import Foundation
import SwiftUI
import WebKit

public struct WebView {
    @ObservedObject private var viewModel: WebViewModel

    public init(viewModel: WebViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: UIViewRepresentable

extension WebView: UIViewRepresentable {

    public func makeCoordinator() -> Coordinator {
        Coordinator(viewModel: viewModel)
    }

    public func makeUIView(context: Context) -> WKWebView {
        guard let url = viewModel.url else {
            return WKWebView()
        }

        let wkWebView = WKWebView()
        let request = URLRequest(url: url)

        wkWebView.navigationDelegate = context.coordinator
        wkWebView.uiDelegate = context.coordinator
        wkWebView.load(request)
        viewModel.subscribe(wkWebView: wkWebView)

        return wkWebView
    }

    public func updateUIView(_ wkWebView: WKWebView, context: Context) {
        Task { @MainActor in
            if viewModel.shouldGoBack {
                _ = wkWebView.goBack()
                viewModel.shouldGoBack = false
            }

            if viewModel.shouldGoForward {
                _ = wkWebView.goForward()
                viewModel.shouldGoForward = false
            }

            if viewModel.shouldLoad {
                guard let url = viewModel.url else {
                    return
                }

                let request = URLRequest(url: url)
                _ = wkWebView.load(request)
                viewModel.shouldLoad = false
            }
        }
    }
}

// MARK: Coordinator

extension WebView {

    public class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {

        @ObservedObject private var viewModel: WebViewModel
        //        private let parent: WebView

        init(viewModel: WebViewModel) {
            self.viewModel = viewModel
        }

        // MARK: WKNavigationDelegate

        public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        }

        public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            viewModel.isLoading = true
        }

        public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            viewModel.isLoading = false
            viewModel.updateUrl(webView.url)
            viewModel.canGoBack = webView.canGoBack
            viewModel.canGoForward = webView.canGoForward
        }

        public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            viewModel.isLoading = false
            setError(error)
        }

        public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            viewModel.isLoading = false
            setError(error)
        }

        private func setError(_ error: Error) {
            if let error = error as? URLError {
                viewModel.error = WebViewModel.Error(code: error.code, message: error.localizedDescription)
            }
        }

        // MARK: WKUIDelegate

        public func webView(
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

        public func webView(
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
}
