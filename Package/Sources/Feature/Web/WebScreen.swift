//
//  WebScreen.swift
//
//
//  Created by Yoshiki Hemmi on 2022/09/30.
//

import SwiftUI

public struct WebScreen: View { // swiftlint:disable:this file_types_order

    @ObservedObject var viewModel: WebViewModel
    private let webView: WebView

    public var body: some View {
        WebContentView(viewModel: viewModel, webView: webView)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    public init(url: String) {
        webView = .init(url: url)
        viewModel = webView.viewModel
    }
}

private struct WebContentView: View {
    @ObservedObject var viewModel: WebViewModel
    var webView: WebView

    var body: some View {
        ZStack(alignment: .bottom) {
            webView.onAppear {
                webView.load(url: viewModel.url)
            }

            ProgressView(value: viewModel.estimatedProgress)
                .opacity(viewModel.isLoadCompleted ? 0 : 1)
                .transition(.opacity)
        }
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button {
                    webView.goBack()
                } label: {
                    Image(systemName: "chevron.left")
                }
                .disabled(!viewModel.canGoBack)

                Button {
                    webView.goForward()
                } label: {
                    Image(systemName: "chevron.right")
                }
                .disabled(!viewModel.canGoForward)

                Spacer()

                Button {
                    webView.reload()
                } label: {
                    Image(systemName: "arrow.clockwise")
                }
            }
        }
    }
}

struct WebContentScreen_Previews: PreviewProvider {
    static var previews: some View {
        WebScreen(url: "https://github.com/signup")
    }
}
