//
//  SignUpHomeScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/13.
//

import SwiftUI
import UI_Core

public struct SignUpHomeScreen<Content: View>: View {
    @StateObject private var viewModel: SignUpHomeViewModel = .init()
    private let navigate: (Navigation.Path) -> Void
    private let content: (Navigation.Path) -> Content

    public var body: some View {
        signUpOrInView {
            viewModel.uiState.update(state: .signIn)
        } onClickSignUp: {
            viewModel.uiState.update(state: .signUp)
        }
        .sheet(item: $viewModel.uiState.activeSheet) { sheet in
            switch sheet {
            case .signIn:
                content(.signIn)
            case .signUp:
                content(.signUp)
            }
        }
        //        .signUpHomeSheet(
        //            item: $viewModel.uiState.activeSheet,
        //            content: content
        //        )
        .onChange(of: viewModel.uiState.state) { state in
            if state == .loggedIn {
                viewModel.uiState.activeSheet = nil
                navigate(.tabHome)
            }
        }
    }

    public init(
        navigate: @escaping (Navigation.Path) -> Void,
        @ViewBuilder content: @escaping (Navigation.Path) -> Content
    ) {
        self.navigate = navigate
        self.content = content
    }
}

private extension SignUpHomeScreen {
    func signUpOrInView (
        onClickSignIn: @escaping () -> Void,
        onClickSignUp: @escaping () -> Void
    ) -> some View {
        VStack(spacing: 32) {
            signInButton(action: onClickSignIn)
            signUpButton(action: onClickSignUp)
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .padding(.horizontal)
    }

    func signInButton(
        action: @escaping () -> Void
    ) -> some View {
        Button {
            action()
        } label: {
            Text(L10n.Button.signIn)
                .fontWeight(.bold)
                .foregroundColor(.accentColor)
                .frame(maxWidth: .infinity)
                .padding()
        }
        .buttonStyle(.bordered)
        .tint(.white.opacity(0.001))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.blue, lineWidth: 2)
        )
    }

    func signUpButton(
        action: @escaping () -> Void
    ) -> some View {
        Button {
            action()
        } label: {
            Text(L10n.Button.signUp)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .padding()
        }
        .buttonStyle(.borderedProminent)
    }

    func signUpHomeSheet(
        item: Binding<SignUpHomeUIState.ActiveSheet?>,
        @ViewBuilder content: @escaping (Navigation.Path) -> Content
    ) -> some View {
        sheet(item: item) { sheet in
            switch sheet {
            case .signIn:
                content(.signIn)
            case .signUp:
                content(.signUp)
            }
        }
    }
}

struct SignUpHomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpHomeScreen { _ in } content: { _ in }
    }
}
