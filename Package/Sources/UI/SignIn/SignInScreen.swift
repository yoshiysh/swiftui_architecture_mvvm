//
//  SignInScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by Yoshiki Hemmi on 2022/09/14.
//

import SwiftUI

public struct SignInScreen: View {
    
    @StateObject private var viewModel: SignInViewModel
    var onComplete: (() -> Void)
    
    public var body: some View {
        SignInView(viewModel)
            .onChange(of: viewModel.state) { state in
                if state == .suceess { onComplete() }
            }
    }
    
    public init(
        _ viewModel: SignInViewModel? = nil,
        _ onComplete: @escaping (() -> Void)
    ) {
        _viewModel = StateObject(wrappedValue: viewModel ?? .init())
        self.onComplete = onComplete
    }
}

private struct SignInView: View {
    
    @ObservedObject var viewModel: SignInViewModel
    
    var body: some View {
        VStack {
            VStack {
                InputMailAddress(
                    text: $viewModel.email,
                    onSubmit: { viewModel.onEmailCommit.send() }
                )
                .padding(.bottom)
                
                InputPassword(
                    text: $viewModel.password,
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
        .padding(.horizontal)
    }
    
    public init(_ viewModel: SignInViewModel) {
        self.viewModel = viewModel
    }
}

private struct InputMailAddress: View {
    @Binding var text: String
    var onSubmit: (() -> Void)
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("メールアドレス")
                    .font(.footnote)
                    .foregroundColor(.accentColor)
                
                TextField("メールアドレス", text: $text)
                    .frame(height: 36)
                    .submitLabel(.next)
                    .onSubmit { onSubmit() }
            }
            
            Divider()
        }
    }
}

private struct InputPassword: View {
    @Binding var text: String
    var onSubmit: (() -> Void)
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("パスワード")
                    .font(.footnote)
                    .foregroundColor(.accentColor)
                
                SecureField("6~12文字のパスワード", text: $text)
                    .frame(height: 36)
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
