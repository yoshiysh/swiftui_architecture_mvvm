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

public struct SignUpHomeScreen: View {
    @StateObject private var viewModel: SignUpHomeViewModel = .init()
    private let onLoggedIn: () -> Void

    public var body: some View {
        signUpOrInView {
            viewModel.uiState.update(state: .signIn)
        } onClickSignUp: {
            viewModel.uiState.update(state: .signUp)
        }
        .signUpHomeSheet(item: $viewModel.uiState.activeSheet) {
            viewModel.uiState.update(state: .loggedIn)
        }
        .onChange(of: viewModel.uiState.state) { state in
            if state == .loggedIn { onLoggedIn() }
        }
    }

    public init(onLoggedIn: @escaping (() -> Void)) {
        self.onLoggedIn = onLoggedIn
    }
}

private extension View {
    func signUpOrInView (
        onClickSignIn: @escaping () -> Void,
        onClickSignUp: @escaping () -> Void
    ) -> some View {
        VStack(spacing: 32) {
            signInButton(action: onClickSignIn)
            signUpButton(action: onClickSignUp)
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .padding(.horizontal)
    }

    func signInButton(
        action: @escaping () -> Void
    ) -> some View {
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

    func signUpButton(
        action: @escaping () -> Void
    ) -> some View {
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

    func signUpHomeSheet(
        item: Binding<SignUpHomeUIState.ActiveSheet?>,
        onLoggedIn: @escaping () -> Void
    ) -> some View {
        sheet(item: item) { sheet in
            switch sheet {
            case .signIn:
                SignInScreen(onLoggedIn: onLoggedIn)
            case .signUp:
                SignUpScreen()
            }
        }
    }
}

struct SignUpHomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpHomeScreen {}
    }
}
