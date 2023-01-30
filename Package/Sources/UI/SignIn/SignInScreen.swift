//
//  SignInScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/14.
//

import SwiftUI

public struct SignInScreen: View { // swiftlint:disable:this file_types_order

    @StateObject private var viewModel: SignInViewModel = .init()
    @FocusState private var focusState: SignInFocusState?

    var onComplete: (() -> Void)

    public var body: some View {
        NavigationView {
            SignInView(viewModel: viewModel, focusState: _focusState)
                .navigationTitle(L10n.Navigation.title)
        }
        .onChange(of: viewModel.state) { state in
            if state == .suceess { onComplete() }
        }
        .onChange(of: viewModel.focusState) { state in
            focusState = state
        }
        .onAppear {
            Task {
                try await Task.sleep(nanoseconds: 200_000_000)
                self.viewModel.initializeFocusState()
            }
        }
    }

    public init(_ onComplete: @escaping (() -> Void)) {
        self.onComplete = onComplete
    }
}

private struct SignInView: View {

    @ObservedObject var viewModel: SignInViewModel
    @FocusState var focusState: SignInFocusState?

    var body: some View {
        VStack {
            VStack(spacing: 32) {
                InputMailAddress(
                    text: $viewModel.email,
                    focusState: _focusState
                ) { viewModel.didTapSubmitButton() }

                InputPassword(
                    text: $viewModel.password,
                    focusState: _focusState
                ) { viewModel.didTapSubmitButton() }
            }

            LoginButton(enabled: $viewModel.isSubmitButtonEnabled) {
                viewModel.onCommit()
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .padding()
    }
}

private struct InputMailAddress: View {
    @Binding var text: String
    @FocusState var focusState: SignInFocusState?
    var onSubmit: (() -> Void)

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
    @FocusState var focusState: SignInFocusState?
    var onSubmit: (() -> Void)

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
    @Binding var enabled: Bool
    var action: (() -> Void)

    var body: some View {
        Button {
            action()
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
