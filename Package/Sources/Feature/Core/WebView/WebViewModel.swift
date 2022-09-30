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
public final class WebViewModel: NSObject, ObservableObject {

    public struct Error {
        let code: URLError.Code
        let message: String
    }

    @Published var isLoading = false
    @Published var canGoBack = false
    @Published var canGoForward = false

    @Published var shouldGoBack = false
    @Published var shouldGoForward = false
    @Published var shouldLoad = false

    @Published var estimatedProgress: Double = 0
    @Published var error: WebViewModel.Error?

    private var cancellables = Set<AnyCancellable>()
    private(set) var url: URL?

    public init(_ url: String) {
        self.url = URL(string: url)
    }

    func updateUrl(_ url: URL?) {
        guard let url = url else {
            return
        }
        self.url = url
    }

    func load(_ url: String) {
        load(URL(string: url))
    }

    func load(_ url: URL?) {
        if url == nil {
            self.error = Self.Error(code: URLError.badURL, message: "Bad URL.")
            return
        }

        self.url = url
        shouldLoad = true
    }

    func subscribe(wkWebView: WKWebView) {
        wkWebView.publisher(for: \.estimatedProgress)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                self?.estimatedProgress = value
            }
            .store(in: &cancellables)
    }
}
