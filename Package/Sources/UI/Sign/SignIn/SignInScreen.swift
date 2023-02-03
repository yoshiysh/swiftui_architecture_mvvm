//
//  SignInScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/14.
//

import SwiftUI
import UI_Core

struct SignInScreen: View { // swiftlint:disable:this file_types_order
    @StateObject private var viewModel: SignInViewModel = .init()
    @FocusState private var focusState: SignInViewUIState.FocusState?

    private let navigate: (Navigation.Path) -> Void

    var body: some View {
        SignInView(
            email: $viewModel.uiState.email,
            password: $viewModel.uiState.password,
            isSubmitButtonEnabled: viewModel.uiState.isSubmitButtonEnabled,
            focusState: _focusState,
            onTapEmailSubmitButton: { viewModel.didTapSubmitButton() },
            onTapPasswordSubmitButton: { viewModel.didTapSubmitButton() },
            onTapSignInButton: {
                Task { await viewModel.signIn() }
            }
        )
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

private struct SignInView: View {
    @Binding var email: String
    @Binding var password: String
    let isSubmitButtonEnabled: Bool
    @FocusState var focusState: SignInViewUIState.FocusState?

    let onTapEmailSubmitButton: (() -> Void)
    let onTapPasswordSubmitButton: (() -> Void)
    let onTapSignInButton: (() -> Void)

    var body: some View {
        VStack {
            VStack(spacing: 32) {
                InputMailAddress(
                    text: _email,
                    focusState: _focusState
                ) { onTapEmailSubmitButton() }

                InputPassword(
                    text: _password,
                    focusState: _focusState
                ) { onTapPasswordSubmitButton() }
            }

            LoginButton(enabled: isSubmitButtonEnabled) {
                onTapSignInButton()
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .padding()
    }
}

private struct InputMailAddress: View {
    @Binding var text: String
    @FocusState var focusState: SignInViewUIState.FocusState?
    let onSubmit: (() -> Void)

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(L10n.SignIn.MailAddress.title)
                    .font(.footnote)
                    .foregroundColor(.accentColor)

                TextField(L10n.SignIn.MailAddress.placeholder, text: $text)
                    .frame(height: 36)
                    .focused($focusState, equals: .email)
                    .submitLabel(.next)
                    .onSubmit { onSubmit() }
            }

            Divider()
        }
    }
}

private struct InputPassword: View {
    @Binding var text: String
    @FocusState var focusState: SignInViewUIState.FocusState?
    let onSubmit: (() -> Void)

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(L10n.SignIn.Password.title)
                    .font(.footnote)
                    .foregroundColor(.accentColor)

                SecureField(L10n.SignIn.Password.placeholder, text: $text)
                    .frame(height: 36)
                    .focused($focusState, equals: .password)
                    .submitLabel(.done)
                    .onSubmit { onSubmit() }
            }

            Divider()
        }
    }
}

private struct LoginButton: View {
    let enabled: Bool
    let onSubmit: (() -> Void)

    var body: some View {
        Button {
            onSubmit()
        } label: {
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
