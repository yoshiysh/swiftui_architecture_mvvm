//
//  WebView.swift
//
//
//  Created by Yoshiki Hemmi on 2022/10/01.
//

import Foundation
import SwiftUI
import WebKit

struct WebView {
    @ObservedObject private var viewState: WebViewStateModel

    init(viewState: WebViewStateModel) {
        self.viewState = viewState
    }
}

// MARK: UIViewRepresentable

extension WebView: UIViewRepresentable {
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
