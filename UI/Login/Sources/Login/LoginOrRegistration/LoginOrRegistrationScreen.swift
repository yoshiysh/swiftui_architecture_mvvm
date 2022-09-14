//
//  LoginOrRegistrationScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by Yoshiki Hemmi on 2022/09/13.
//

import SwiftUI
import Home

public struct LoginOrRegistrationScreen: View {
    
    @ObservedObject var viewModel: LoginOrRegistrationViewModel
    @ObservedObject var loginViewModel: LoginViewModel
    
    public var body: some View {
        if (loginViewModel.output.state == .suceess) {
            HomeScreen()
        } else {
            LoginOrRegistrationView(
                viewModel: viewModel,
                loginViewModel: loginViewModel
            )
            .sheet(isPresented: viewModel.$binding.isShowingSheet) {
                switch viewModel.output.state {
                case .login:
                    LoginScreen(loginViewModel)
                case .registration:
                    ResistrationScreen()
                default:
                    EmptyView()
                }
            }
        }
    }
    
    public init(
        _ viewModel: LoginOrRegistrationViewModel = LoginOrRegistrationViewModel(),
        _ loginViewModel: LoginViewModel = LoginViewModel()
    ) {
        self.viewModel = viewModel
        self.loginViewModel = loginViewModel
    }
}

private struct LoginOrRegistrationView: View {
    var viewModel: LoginOrRegistrationViewModel
    var loginViewModel: LoginViewModel
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack(spacing: 0) {
                    Spacer()
                    
                    LoginButton(
                        action: { viewModel.updateState(.login) }
                    )
                    
                    Spacer().frame(height: 24)
                    
                    ResistrationButton(
                        action: { viewModel.updateState(.registration) }
                    )
                    
                    Spacer()
                        .frame(maxWidth: .infinity)
                        .frame(height: geometry.safeAreaInsets.bottom)
                }
            }
        }
    }
}

private struct LoginButton: View {
    var action: (() -> Void)
    
    var body: some View {
        Button {
            action()
        } label: {
            Text("ログイン")
                .fontWeight(.bold)
                .foregroundColor(.blue)
                .frame(maxWidth: .infinity)
                .padding(.all)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.blue, lineWidth: 2)
                )
                .padding(.horizontal)
        }
    }
}

private struct ResistrationButton: View {
    var action: (() -> Void)
    
    var body: some View {
        Button {
            action()
        } label: {
            Text("新規登録")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.all)
                .background(.blue)
                .cornerRadius(8)
                .padding(.horizontal)
        }
    }
}

struct LoginOrRegistrationScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginOrRegistrationScreen()
    }
}
