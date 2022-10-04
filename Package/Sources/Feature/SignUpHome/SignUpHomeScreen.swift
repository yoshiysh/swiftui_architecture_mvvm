//
//  SignUpHomeScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/13.
//

import SwiftUI

struct SignUpHomeScreen: View { // swiftlint:disable:this file_types_order

    @StateObject private var viewModel: SignUpHomeViewModel = .init()
    private var onLoggedIn: (() -> Void)

    var body: some View {
        SignUpOrInView(viewModel)
            .sheet(isPresented: $viewModel.isShowingSheet) {
                switch viewModel.state {
                case .signIn:
                    SignInScreen { viewModel.updateState(.loggedIn) }
                case .signUp:
                    SignUpScreen()
                case .loggedIn, .initialized:
                    EmptyView()
                }
            }
            .onChange(of: viewModel.state) { state in
                if state == .loggedIn { onLoggedIn() }
            }
    }

    init(onLoggedIn: @escaping (() -> Void)) {
        self.onLoggedIn = onLoggedIn
    }
}

private struct SignUpOrInView: View {

    @ObservedObject var viewModel: SignUpHomeViewModel

    var body: some View {
        VStack(spacing: 32) {
            SignInButton {
                viewModel.updateState(.signIn)
            }

            SignUpButton {
                viewModel.updateState(.signUp)
            }
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .padding(.horizontal)
    }

    init(_ viewModel: SignUpHomeViewModel) {
        self.viewModel = viewModel
    }
}

private struct SignInButton: View {
    var action: (() -> Void)

    var body: some View {
        Button {
            action()
        } label: {
            Text("ログイン")
                .fontWeight(.bold)
                .foregroundColor(.accentColor)
                .frame(maxWidth: .infinity)
                .padding()
        }
        .buttonStyle(.bordered)
        .tint(.white.opacity(0.001))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.blue, lineWidth: 2)
        )
    }
}

private struct SignUpButton: View {
    var action: (() -> Void)

    var body: some View {
        Button {
            action()
        } label: {
            Text("新規登録")
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .padding()
        }
        .buttonStyle(.borderedProminent)
    }
}

struct SignUpHomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpHomeScreen {}
    }
}
