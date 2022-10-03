//
//  WebViewUIStateModel.swift
//
//
//  Created by Yoshiki Hemmi on 2022/10/03.
//

import Combine
import Foundation
import WebKit

@MainActor
class WebViewUIStateModel: ObservableObject {

    @Published var isLoading = false
    @Published var canGoBack = false
    @Published var canGoForward = false
    @Published var estimatedProgress: Double = 0
    @Published var error: WebViewError?

    private var cancellables = Set<AnyCancellable>()

    func handleError(_ error: Error? = nil) {
        self.error = .handleError(error)
    }

    func subscribe(wkWebView: WKWebView) {
        wkWebView.publisher(for: \.isLoading)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.isLoading = value
            }
            .store(in: &cancellables)

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
