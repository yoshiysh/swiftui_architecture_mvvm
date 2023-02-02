//
//  SignUpHomeScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/13.
//

import SwiftUI
import UI_Core
import UI_SignIn
import UI_SignUp

public struct SignUpHomeScreen: View { // swiftlint:disable:this file_types_order
    @StateObject private var viewModel: SignUpHomeViewModel = .init()
    private let onLoggedIn: () -> Void

    public var body: some View {
        SignUpOrInView(
            onClickSignIn: { viewModel.updateState(.signIn) },
            onClickSignUp: { viewModel.updateState(.signUp) }
        )
        .sheet(isPresented: $viewModel.uiState.isShowingSheet) {
            switch viewModel.uiState.state {
            case .signIn:
                SignInScreen { viewModel.updateState(.loggedIn) }
            case .signUp:
                SignUpScreen()
            case .loggedIn, .initialized:
                EmptyView()
            }
        }
        .onChange(of: viewModel.uiState.state) { state in
            if state == .loggedIn { onLoggedIn() }
        }
    }

    public init(onLoggedIn: @escaping (() -> Void)) {
        self.onLoggedIn = onLoggedIn
    }
}

private struct SignUpOrInView: View {
    let onClickSignIn: () -> Void
    let onClickSignUp: () -> Void

    var body: some View {
        VStack(spacing: 32) {
            SignInButton(action: onClickSignIn)
            SignUpButton(action: onClickSignUp)
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .padding(.horizontal)
    }
}

private struct SignInButton: View {
    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            Text(L10n.Button.signIn)
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
    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            Text(L10n.Button.signUp)
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
