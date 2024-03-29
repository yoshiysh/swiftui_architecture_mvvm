//
//  WebView.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/10/01.
//

import Foundation
import SwiftUI
import WebKit

struct WebView {
    @ObservedObject private var viewModel: WebViewModel

    init(viewModel: WebViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: UIViewRepresentable

extension WebView: UIViewRepresentable {
    typealias Coordinator = WebViewCoordinator

    func makeCoordinator() -> Coordinator {
        WebViewCoordinator(viewModel: viewModel)
    }

    func makeUIView(context: Context) -> WKWebView {
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

    func updateUIView(_ wkWebView: WKWebView, context: Context) {
        guard viewModel.willWebViewUpdate else {
            return
        }

        switch viewModel.webViewState {
        case .goBack:
            _ = wkWebView.goBack()
        case .goForward:
            _ = wkWebView.goForward()
        case .reload:
            guard let url = viewModel.url else {
                return
            }

            let request = URLRequest(url: url)
            _ = wkWebView.load(request)
        case nil:
            break
        }
        viewModel.resetWebViewState()
    }
}
