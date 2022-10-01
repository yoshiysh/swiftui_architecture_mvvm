//
//  WebScreen.swift
//
//
//  Created by Yoshiki Hemmi on 2022/09/30.
//

import SwiftUI

public struct WebScreen: View { // swiftlint:disable:this file_types_order

    @ObservedObject private var viewState: WebViewStateModel

    public var body: some View {
        NavigationView {
            WebContentView(viewState: viewState)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    public init(_ url: String) {
        viewState = .init(url: url)
    }
}

private struct WebContentView: View {
    @ObservedObject var viewState: WebViewStateModel

    var body: some View {
        ZStack(alignment: .bottom) {
            WebView(viewState: viewState)

            ProgressView(value: viewState.estimatedProgress)
                .opacity(viewState.isLoading ? 1 : 0)
                .transition(.opacity)
        }
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button {
                    viewState.shouldGoBack = true
                } label: {
                    Image(systemName: "chevron.left")
                }
                .disabled(!viewState.canGoBack)

                Button {
                    viewState.shouldGoForward = true
                } label: {
                    Image(systemName: "chevron.right")
                }
                .disabled(!viewState.canGoForward)

                Spacer()

                Button {
                    viewState.shouldLoad = true
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
