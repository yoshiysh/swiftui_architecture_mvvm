//
//  SignInScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/14.
//

import SwiftUI
import UI_Core

struct SignInScreen: View {
    enum ActionType {
        case email, password, submit
    }

    @StateObject private var viewModel: SignInViewModel = .init()
    @FocusState private var focusState: SignInViewUIState.FocusState?

    private let navigate: (Navigation.Path) -> Void

    var body: some View {
        signInView(
            email: $viewModel.uiState.email,
            password: $viewModel.uiState.password,
            isSubmitButtonEnabled: viewModel.uiState.isSubmitButtonEnabled
        ) { type in
            switch type {
            case .email:
                viewModel.didTapSubmitButton()
            case .password:
                viewModel.didTapSubmitButton()
            case .submit:
                Task { await viewModel.signIn() }
            }
        }
        .navigationTitle(L10n.SignIn.Navigation.title)
        .onChange(of: viewModel.uiState.state) { state in
            if state == .suceess { navigate(.tabHome) }
        }
        .onChange(of: viewModel.uiState.focusState) { state in
            focusState = state
        }
        .onChange(of: [viewModel.uiState.email, viewModel.uiState.password]) { _ in
            viewModel.updateSubmitButton()
        }
        .task {
            await viewModel.initializeFocusState()
        }
    }

    init(navigate: @escaping (Navigation.Path) -> Void) {
        self.navigate = navigate
    }
}

private extension SignInScreen {
    func signInView(
        email: Binding<String>,
        password: Binding<String>,
        isSubmitButtonEnabled: Bool,
        action: @escaping (ActionType) -> Void
    ) -> some View {
        VStack {
            VStack(spacing: 32) {
                inputMailAddress(text: email) {
                    action(.email)
                }

                inputPassword(text: password) {
                    action(.password)
                }
            }

            loginButton(enabled: isSubmitButtonEnabled) {
                action(.submit)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .padding()
    }

    func inputMailAddress(
        text: Binding<String>,
        action: @escaping () -> Void
    ) -> some View {
        VStack {
            VStack(alignment: .leading) {
                Text(L10n.SignIn.MailAddress.title)
                    .font(.footnote)
                    .foregroundColor(.accentColor)

                TextField(L10n.SignIn.MailAddress.placeholder, text: text)
                    .frame(height: 36)
                    .focused($focusState, equals: .email)
                    .submitLabel(.next)
                    .onSubmit(action)
            }

            Divider()
        }
    }

    func inputPassword(
        text: Binding<String>,
        action: @escaping () -> Void
    ) -> some View {
        VStack {
            VStack(alignment: .leading) {
                Text(L10n.SignIn.Password.title)
                    .font(.footnote)
                    .foregroundColor(.accentColor)

                SecureField(L10n.SignIn.Password.placeholder, text: text)
                    .frame(height: 36)
                    .focused($focusState, equals: .password)
                    .submitLabel(.done)
                    .onSubmit(action)
            }

            Divider()
        }
    }
}

private extension View {
    func loginButton(
        enabled: Bool,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Text(L10n.SignIn.Button.signIn)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .padding()
        }
        .buttonStyle(.borderedProminent)
        .disabled(!enabled)
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreen { _ in }
    }
}
