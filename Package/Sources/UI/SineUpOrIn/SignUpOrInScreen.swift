//
//  SignUpOrInScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by Yoshiki Hemmi on 2022/09/13.
//

import SwiftUI

public struct SignUpOrInScreen: View {
    
    public init(
        _ viewModel: SignUpOrInViewModel = .init()
    ) {
        self.viewModel = viewModel
    }
    
    @ObservedObject var viewModel: SignUpOrInViewModel
    @StateObject var signInViewModel: SignInViewModel = .shared
    
    public var body: some View {
        if (signInViewModel.state == .suceess) {
            TabHomeScreen()
        } else {
            SignUpOrInView(
                viewModel: viewModel,
                signInViewModel: signInViewModel
            )
            .sheet(isPresented: $viewModel.isShowingSheet) {
                switch viewModel.state {
                case .signIn:
                    SignInScreen()
                case .signUp:
                    SignUpScreen()
                default:
                    EmptyView()
                }
            }
        }
    }
}

private struct SignUpOrInView: View {
    var viewModel: SignUpOrInViewModel
    @ObservedObject var signInViewModel: SignInViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            LoginButton(
                action: { viewModel.updateState(.signIn) }
            )
            
            Spacer().frame(height: 24)
            
            ResistrationButton(
                action: { viewModel.updateState(.signUp) }
            )
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
                .foregroundColor(.accentColor)
                .frame(maxWidth: .infinity)
                .padding(.all)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.primary, lineWidth: 2)
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
                .background(.primary)
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
