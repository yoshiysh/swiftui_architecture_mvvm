//
//  SignInScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by Yoshiki Hemmi on 2022/09/14.
//

import SwiftUI

public struct SignInScreen: View {
    
    @StateObject private var viewModel: SignInViewModel = .init()
    @FocusState var focusState: SignInFocusState?
    
    var onComplete: (() -> Void)
    
    public var body: some View {
        SignInView(viewModel: viewModel, focusState: _focusState)
            .onChange(of: viewModel.state) { state in
                if state == .suceess { onComplete() }
            }
            .onChange(of: viewModel.focusState) { state in
                focusState = state
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.viewModel.updateFocusState(.email)
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
                    focusState: _focusState,
                    onSubmit: { viewModel.onEmailCommit.send() }
                )
                
                InputPassword(
                    text: $viewModel.password,
                    focusState: _focusState,
                    onSubmit: { viewModel.onPasswordCommit.send() }
                )
            }
            .padding(.vertical)
            
            LoginButton(
                enabled: $viewModel.isSubmitButtonEnabled,
                action: { viewModel.onCommit.send() }
            )
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
                Text("メールアドレス")
                    .font(.footnote)
                    .foregroundColor(.accentColor)
                
                TextField("メールアドレス", text: $text)
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
                Text("パスワード")
                    .font(.footnote)
                    .foregroundColor(.accentColor)
                
                SecureField("6~12文字のパスワード", text: $text)
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
            Text("ログイン")
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
        SignInScreen() {}
    }
}