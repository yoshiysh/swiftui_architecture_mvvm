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
public final class WebViewModel: ObservableObject {

    @Published var canGoBack = false
    @Published var canGoForward = false
    @Published var estimatedProgress: Double = 0
    @Published var isLoadCompleted = false

    let url: URL
    private var cancellables = Set<AnyCancellable>()

    public init(url: String) {
        if let url = URL(string: url) {
            self.url = url
        } else {
            fatalError("Invalid URL.")
        }
    }

    func updateLoadState(isLoadCompleted: Bool) {
        self.isLoadCompleted = isLoadCompleted
    }

    func startObserver(wkWebView: WKWebView) {
        wkWebView.publisher(for: \.canGoBack)
            .sink { [weak self] value in
                self?.canGoBack = value
            }
            .store(in: &cancellables)

        wkWebView.publisher(for: \.canGoForward)
            .sink { [weak self] value in
                self?.canGoForward = value
            }
            .store(in: &cancellables)

        wkWebView.publisher(for: \.estimatedProgress)
            .sink { [weak self] value in
                self?.estimatedProgress = value
            }
            .store(in: &cancellables)
    }
}
