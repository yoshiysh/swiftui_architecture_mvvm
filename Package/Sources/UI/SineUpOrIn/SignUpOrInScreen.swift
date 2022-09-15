//
//  SignUpOrInScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by Yoshiki Hemmi on 2022/09/13.
//

import SwiftUI

public struct SignUpOrInScreen: View {
    
    @ObservedObject var viewModel: SignUpOrInViewModel
    @ObservedObject var loginViewModel: SignInViewModel
    
    public var body: some View {
        if (loginViewModel.output.state == .suceess) {
            TabHomeScreen()
        } else {
            SignUpOrInView(
                viewModel: viewModel,
                loginViewModel: loginViewModel
            )
            .sheet(isPresented: viewModel.$binding.isShowingSheet) {
                switch viewModel.output.state {
                case .signIn:
                    SignInScreen(loginViewModel)
                case .signUp:
                    SignUpScreen()
                default:
                    EmptyView()
                }
            }
        }
    }
    
    public init(
        _ viewModel: SignUpOrInViewModel = SignUpOrInViewModel(),
        _ loginViewModel: SignInViewModel = SignInViewModel()
    ) {
        self.viewModel = viewModel
        self.loginViewModel = loginViewModel
    }
}

private struct SignUpOrInView: View {
    var viewModel: SignUpOrInViewModel
    var loginViewModel: SignInViewModel
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack(spacing: 0) {
                    Spacer()
                    
                    LoginButton(
                        action: { viewModel.updateState(.signIn) }
                    )
                    
                    Spacer().frame(height: 24)
                    
                    ResistrationButton(
                        action: { viewModel.updateState(.signUp) }
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

struct SignUpOrInScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpOrInScreen()
    }
}
