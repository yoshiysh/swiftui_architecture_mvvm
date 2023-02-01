//
//  SignInScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/14.
//

import SwiftUI

public struct SignInScreen: View { // swiftlint:disable:this file_types_order
    @StateObject private var viewModel: SignInViewModel = .init()
    @FocusState private var focusState: SignInViewUIState.FocusState?

    private let onComplete: (() -> Void)

    public var body: some View {
        NavigationView {
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
            .navigationTitle(L10n.Navigation.title)
        }
        .onChange(of: viewModel.uiState.state) { state in
            if state == .suceess { onComplete() }
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

    public init(_ onComplete: @escaping (() -> Void)) {
        self.onComplete = onComplete
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
                Text(L10n.MailAddress.title)
                    .font(.footnote)
                    .foregroundColor(.accentColor)

                TextField(L10n.MailAddress.placeholder, text: $text)
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
                Text(L10n.Password.title)
                    .font(.footnote)
                    .foregroundColor(.accentColor)

                SecureField(L10n.Password.placeholder, text: $text)
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
            Text(L10n.Button.signIn)
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
        SignInScreen {}
    }
}
