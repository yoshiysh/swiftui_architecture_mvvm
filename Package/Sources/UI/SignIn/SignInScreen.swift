//
//  SignInScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by Yoshiki Hemmi on 2022/09/14.
//

import SwiftUI

public struct SignInScreen: View {
    
    public init(_ onComplete: @escaping (() -> Void)) {
        self.onComplete = onComplete
    }
    
    @StateObject var viewModel: SignInViewModel = .shared
    var onComplete: (() -> Void)
    
    public var body: some View {
        SignInView(viewModel)
            .onChange(of: viewModel.state) { state in
                if state == .suceess { onComplete() }
            }
            .onAppear { viewModel.onAppear() }
            .onDisappear { viewModel.onDisappear() }
    }
}

private struct SignInView: View {
    
    public init(_ viewModel: SignInViewModel) {
        self.viewModel = viewModel
    }
    
    @ObservedObject var viewModel: SignInViewModel
    
    var body: some View {
        VStack {
            VStack(spacing: 16) {
                InputMailAddress(
                    text: $viewModel.email,
                    onSubmit: { viewModel.onEmailCommit.send() }
                )
                .padding(.horizontal)
                
                InputPassword(
                    text: $viewModel.password,
                    onSubmit: { viewModel.onPasswordCommit.send() }
                )
                .padding(.horizontal)
            }
            
            LoginButton(
                enabled: $viewModel.isSubmitButtonEnabled,
                action: { viewModel.onCommit.send() }
            )
            .padding(.horizontal)
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
}

private struct InputMailAddress: View {
    @Binding var text: String
    var onSubmit: (() -> Void)
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 8) {
                Text("メールアドレス")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.footnote)
                    .foregroundColor(.blue)
                
                TextField("メールアドレス", text: $text)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 36)
                    .submitLabel(.next)
                    .onSubmit {
                        onSubmit()
                    }
            }
            
            Divider()
        }
    }
}

private struct InputPassword: View {
    @Binding var text: String
    var onSubmit: (() -> Void)
    
    var body: some View {
        VStack(spacing: 8) {
            VStack(spacing: 8) {
                Text("パスワード")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.footnote)
                    .foregroundColor(.blue)
                
                SecureField("6~12文字のパスワード", text: $text)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 36)
                    .submitLabel(.done)
                    .onSubmit {
                        onSubmit()
                    }
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
                .foregroundColor(.white)
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
