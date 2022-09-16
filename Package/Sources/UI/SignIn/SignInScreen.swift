//
//  SignInScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by Yoshiki Hemmi on 2022/09/14.
//

import SwiftUI

public struct SignInScreen: View {
    
    public init(_ viewModel: SignInViewModel? = nil) {
        let vm: SignInViewModel = viewModel != nil ? viewModel! : .shared
        self._viewModel = StateObject(wrappedValue: vm)
    }
    
    @StateObject var viewModel: SignInViewModel
    
    public var body: some View {
        SignInView(viewModel)
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
            Spacer().frame(height: 24)
            
            InputMailAddress(
                text: $viewModel.email,
                onSubmit: { viewModel.onEmailCommit.send() }
            )
            
            InputPassword(
                text: $viewModel.password,
                onSubmit: { viewModel.onPasswordCommit.send() }
            )
            
            Spacer()
            
            LoginButton(
                enabled: $viewModel.isSubmitButtonEnabled,
                action: { viewModel.onCommit.send() }
            )
            
            Spacer().frame(height: 16)
        }
    }
}

private struct InputMailAddress: View {
    @Binding var text: String
    var onSubmit: (() -> Void)
    
    var body: some View {
        VStack(spacing: 0) {
            Text("メールアドレス")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14))
                .foregroundColor(.blue)
            
            Spacer().frame(height: 8)
            
            TextField("メールアドレス", text: $text)
                .frame(maxWidth: .infinity)
                .frame(height: 36, alignment: .leading)
                .submitLabel(.next)
                .onSubmit {
                    onSubmit()
                }
            
            Divider()
        }
        .padding(.horizontal)
        .padding()
    }
}

private struct InputPassword: View {
    @Binding var text: String
    var onSubmit: (() -> Void)
    
    var body: some View {
        VStack(spacing: 0) {
            Text("パスワード")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 14))
                .foregroundColor(.blue)
            
            Spacer().frame(height: 8)
            
            SecureField("6~12文字のパスワード", text: $text)
                .frame(maxWidth: .infinity)
                .frame(height: 36, alignment: .leading)
                .submitLabel(.done)
                .onSubmit {
                    onSubmit()
                }
            
            Divider()
        }
        .padding(.horizontal)
        .padding()
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
                .padding(.all)
                .background(enabled ? .blue : Color(UIColor.lightGray))
                .cornerRadius(8)
                .padding(.horizontal)
        }
        .disabled(!enabled)
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreen()
    }
}
