//
//  SwiftUIView.swift
//  
//
//  Created by Yoshiki Hemmi on 2022/09/14.
//

import SwiftUI

public struct LoginView: View {
    
    @ObservedObject var viewModel: LoginViewModel
    
    public var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer().frame(height: 24)
                
                InputMailAddress(
                    text: viewModel.$binding.email,
                    onSubmit: { viewModel.input.onEmailCommit.send() }
                )
                
                InputPassword(
                    text: viewModel.$binding.password,
                    onSubmit: { viewModel.input.onPasswordCommit.send() }
                )
                
                Spacer()
                
                LoginButton(
                    enabled: viewModel.$binding.isSubmitButtonEnabled,
                    action: {
                        viewModel.input.onCommit.send()
                    }
                )
                
                Spacer().frame(height: 16)
            }
        }
    }
    
    public init(_ viewModel: LoginViewModel = LoginViewModel()) {
        self.viewModel = viewModel
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
