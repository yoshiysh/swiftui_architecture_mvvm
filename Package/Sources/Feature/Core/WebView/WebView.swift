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
    let wkWebView: WKWebView

    public init() {
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preferences

        wkWebView = WKWebView(frame: .zero, configuration: configuration)
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

    public func updateUIView(_ wkWebView: WKWebView, context: Context) {
    }
}

// MARK: Coordinator

extension WebView {
    public class Coordinator: NSObject {
        private let parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }
    }
}

// MARK: WebKit Wrapper

extension WebView {
    public func load(url: URL) {
        wkWebView.load(.init(url: url))
    }

    public func goBack() {
        wkWebView.goBack()
    }

    public func goForward() {
        wkWebView.goForward()
    }

    public func reload() {
        wkWebView.reload()
    }
}
