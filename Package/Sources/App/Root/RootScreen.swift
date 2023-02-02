//
//  RootScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/13.
//

import SwiftUI
import UI_SignUpHome
import UI_Splash
import UI_TabHome

public struct RootScreen: View {
    @StateObject private var viewModel: RootViewModel = .init()

    public var body: some View {
        rootView(state: viewModel.uiState.state) {
            viewModel.uiState.update(state: .loggedIn)
        } navigateToSignUp: {
            viewModel.uiState.update(state: .loggedOut)
        }
        .task {
            await viewModel.getUser()
        }
    }

    public init() {}
}

private extension View {
    func rootView(
        state: RootUIState.State,
        navigateToHome: @escaping () -> Void,
        navigateToSignUp: @escaping () -> Void
    ) -> some View {
        Group {
            switch state {
            case .initialized:
                SplashScreen()
            case .loggedOut:
                SignUpHomeScreen(onLoggedIn: navigateToHome)
            case .loggedIn:
                TabHomeScreen(onLoggedOut: navigateToSignUp)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}
