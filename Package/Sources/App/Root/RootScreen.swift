//
//  RootScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/13.
//

import SwiftUI
import UI_Core
import UI_Home
import UI_Search
import UI_Setting
import UI_SignIn
import UI_SignUp
import UI_SignUpHome
import UI_Splash
import UI_TabHome
import UI_Web

public struct RootScreen: View {
    @StateObject private var viewModel: RootViewModel = .init()
    @StateObject private var navigator: Navigator = .shared

    public var body: some View {
        rootView()
            .task {
                await viewModel.getUser()
            }
    }

    public init() {}
}

private extension RootScreen {
    func rootView() -> some View {
        Group {
            switch viewModel.uiState.state {
            case .initialized:
                splash()
            case .loggedOut:
                signUpHome()
            case .loggedIn:
                tabHome()
            }
        }
    }

    func splash() -> some View {
        SplashScreen()
    }

    func signUpHome() -> some View {
        SignUpHomeScreen(onLoggedIn: navigateToHome)
    }

    func tabHome() -> some View {
        TabHomeScreen { tab in
            switch tab {
            case .home:
                home()
            case .search:
                search()
            }
        }
    }

    func home() -> some View {
        HomeScreen { path in
            switch path {
            case .signUpHome:
                navigateToSignUpHome()
            default:
                navigator.navigate(to: path)
            }
        } content: { destination in
            switch destination {
            case .search:
                search()
            case .setting:
                setting()
            default:
                EmptyView()
            }
        }
    }

    func setting() -> some View {
        SettingScreen(onClickLoggedOut: navigateToSignUpHome) {
            navigator.navigate(to: .search)
        }
    }

    func search() -> some View {
        SearchScreen()
    }

    private func navigateToHome() {
        viewModel.uiState.update(state: .loggedIn)
    }

    private func navigateToSignUpHome() {
        viewModel.uiState.update(state: .loggedOut)
        navigator.removeAll()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}
