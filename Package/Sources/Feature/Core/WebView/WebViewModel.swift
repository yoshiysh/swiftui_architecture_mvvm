//
//  WebViewModel.swift
//
//
//  Created by Yoshiki Hemmi on 2022/10/01.
//

import Combine
import Foundation
import WebKit

@MainActor
final class WebViewModel: ObservableObject {

    @Published var shouldLoad = false

    private(set) var webViewState: WebViewState?
    private(set) var uiState: WebViewUIStateModel?
    private(set) var url: URL?

    init(url: String) {
        self.url = URL(string: url)
    }

    func setUIState(_ uiState: WebViewUIStateModel) {
        self.uiState = uiState
    }

    func updateState(webViewState: WebViewState?) {
        self.webViewState = webViewState
        shouldLoad = true
    }

    func resetWebViewState() {
        webViewState = nil
    }

    func current(url: URL?) {
        guard let url = url else {
            return
        }
        self.url = url
    }

    func load(url: String) {
        load(url: URL(string: url))
    }

    func load(url: URL?) {
        if url == nil {
            handleError()
            return
        }

        self.url = url
        shouldLoad = true
    }

    func handleError(_ error: Error? = nil) {
        uiState?.handleError(error)
    }

    func subscribe(wkWebView: WKWebView) {
        uiState?.subscribe(wkWebView: wkWebView)
    }
}
