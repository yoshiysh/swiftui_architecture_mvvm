//
//  WebScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/30.
//

import SwiftUI

public struct WebScreen: View { // swiftlint:disable:this file_types_order

    @ObservedObject private var viewModel: WebViewModel
    @ObservedObject private var uiState: WebViewUIStateModel = .init()

    public var body: some View {
        NavigationView {
            WebContentView(viewModel: viewModel, uiState: uiState)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    public init(_ url: String) {
        viewModel = .init(url: url)
        viewModel.setUIState(uiState)
    }
}

private struct WebContentView: View {
    @ObservedObject var viewModel: WebViewModel
    @ObservedObject var uiState: WebViewUIStateModel

    var body: some View {
        ZStack(alignment: .bottom) {
            WebView(viewModel: viewModel)

            ProgressView(value: uiState.estimatedProgress)
                .opacity(uiState.isLoading ? 1 : 0)
                .transition(.opacity)
        }
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button {
                    viewModel.updateState(webViewState: .goBack)
                } label: {
                    Image(systemName: "chevron.left")
                }
                .disabled(!uiState.canGoBack)

                Button {
                    viewModel.updateState(webViewState: .goForward)
                } label: {
                    Image(systemName: "chevron.right")
                }
                .disabled(!uiState.canGoForward)

                Spacer()

                Button {
                    viewModel.updateState(webViewState: .reload)
                } label: {
                    Image(systemName: "arrow.clockwise")
                }
            }
        }
    }
}

struct WebContentScreen_Previews: PreviewProvider {
    static var previews: some View {
        WebScreen("https://github.com/signup")
    }
}
