//
//  WebView.swift
//
//
//  Created by Yoshiki Hemmi on 2022/09/30.
//

import Combine
import SwiftUI
import WebKit

public struct WebView {

    @StateObject var viewModel: WebViewModel

    private let wkWebView: WKWebView = .init()

    public init(url: String) {
        _viewModel = StateObject(wrappedValue: .init(url: url))
        viewModel.startObserver(wkWebView: wkWebView)
    }
}

// MARK: Coordinator

extension WebView {
    public class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate {
        private let parent: WebView
        private let viewModel: WebViewModel

        init(_ parent: WebView) {
            self.parent = parent
            viewModel = parent.viewModel
        }

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

        @MainActor
        public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            viewModel.updateLoadState(isLoadCompleted: false)
        }

        @MainActor
        public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            viewModel.updateLoadState(isLoadCompleted: true)
        }

        @MainActor
        public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            viewModel.updateLoadState(isLoadCompleted: true)
        }
    }
}

// MARK: UIViewRepresentable

extension WebView: UIViewRepresentable {
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    public func makeUIView(context: Context) -> WKWebView {
        wkWebView
    }

    public func updateUIView(_ uiView: WKWebView, context: Context) {
        wkWebView.uiDelegate = context.coordinator
        wkWebView.navigationDelegate = context.coordinator
        wkWebView.allowsBackForwardNavigationGestures = true
        wkWebView.load(.init(url: viewModel.url))
    }
}

// MARK: WebKit Wrapper

public extension WebView {
    func load(url: URL) {
        wkWebView.load(.init(url: url))
    }

    func goBack() {
        wkWebView.goBack()
    }

    func goForward() {
        wkWebView.goForward()
    }

    func reload() {
        wkWebView.reload()
    }
}
