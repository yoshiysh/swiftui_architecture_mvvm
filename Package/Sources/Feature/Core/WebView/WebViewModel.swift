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

    @Published var shouldGoBack = false
    @Published var shouldGoForward = false
    @Published var shouldLoad = false

    private(set) var uiState: WebViewUIStateModel?
    private(set) var url: URL?

    init(url: String) {
        self.url = URL(string: url)
    }

    func setUIState(_ uiState: WebViewUIStateModel) {
        self.uiState = uiState
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
            uiState?.error = WebViewError(code: URLError.badURL, message: "Bad URL.")
            return
        }

        self.url = url
        shouldLoad = true
    }

    func handleError(_ error: Error) {
        uiState?.handleError(error)
    }

    func subscribe(wkWebView: WKWebView) {
        uiState?.subscribe(wkWebView: wkWebView)
    }
}
