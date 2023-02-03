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
import UI_Sign
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
                navigationSignUpHome()
            case .loggedIn:
                tabHome()
            }
        }
    }

    func splash() -> some View {
        SplashScreen()
    }

    func signUpHome() -> some View {
        SignUpHomeScreen(navigate: navigate, content: content)
    }

    func tabHome() -> some View {
        TabHomeScreen { tab in
            switch tab {
            case .home:
                navigationHome()
            case .search:
                navigationSearch()
            }
        }
    }

    func home() -> some View {
        HomeScreen(navigate: navigate)
    }

    func setting() -> some View {
        SettingScreen(navigate: navigate)
    }

    func search() -> some View {
        SearchScreen()
    }

    func web(url: String) -> some View {
        WebScreen(url)
    }

    func navigationHome() -> some View {
        NavigationStack(path: $navigator.navigation.path) {
            home()
                .appNavigationDestination(content: content)
        }
    }

    func navigationSearch() -> some View {
        NavigationStack {
            search()
        }
    }

    func navigationSignUpHome() -> some View {
        NavigationStack {
            signUpHome()
        }
    }

    func navigateToHome() {
        viewModel.uiState.update(state: .loggedIn)
    }

    func navigateToSignUpHome() {
        viewModel.uiState.update(state: .loggedOut)
        navigator.removeAll()
    }

    func navigate(path: Navigation.Path) {
        switch path {
        case .signUpHome:
            navigateToSignUpHome()
        case .tabHome:
            navigateToHome()
        default:
            navigator.navigate(to: path)
        }
    }

    @ViewBuilder func content(path: Navigation.Path) -> some View {
        switch path {
        case .search:
            search()
        case .setting:
            setting()
        case .web(let url):
            web(url: url)
        default:
            fatalError("undefined")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}
