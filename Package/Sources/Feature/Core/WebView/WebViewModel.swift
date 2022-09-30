//
//  WebViewModel.swift
//
//
//  Created by Yoshiki Hemmi on 2022/09/30.
//

import Combine
import Foundation
import WebKit

@MainActor
public final class WebViewModel: NSObject, ObservableObject {

    @Published var canGoBack = false
    @Published var canGoForward = false
    @Published var estimatedProgress: Double = 0
    @Published var isLoadCompleted = false

    weak var wkWebView: WKWebView? {
        didSet {
            if let wkWebView = self.wkWebView {
                wkWebView.uiDelegate = self
                wkWebView.navigationDelegate = self
                wkWebView.allowsBackForwardNavigationGestures = true

                startObserver(wkWebView: wkWebView)
            }
        }
    }

    private var cancellables = Set<AnyCancellable>()

    override public init() {}

    private func startObserver(wkWebView: WKWebView) {
        wkWebView.publisher(for: \.canGoBack)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.canGoBack = value
            }
            .store(in: &cancellables)

        wkWebView.publisher(for: \.canGoForward)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.canGoForward = value
            }
            .store(in: &cancellables)

        wkWebView.publisher(for: \.estimatedProgress)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.estimatedProgress = value
            }
            .store(in: &cancellables)
    }
}

// MARK: WKNavigationDelegate

extension WebViewModel: WKNavigationDelegate {

    public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        isLoadCompleted = false
    }

    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        isLoadCompleted = true
    }

    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        isLoadCompleted = true
    }
}

// MARK: WKUIDelegate

extension WebViewModel: WKUIDelegate {

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
