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
import UI_SideMenu
import UI_Sign
import UI_Splash
import UI_TabHome
import UI_Web

public struct RootScreen: View {
    @StateObject private var viewModel: RootViewModel = .init()
    @StateObject private var navigator: Navigator = .init()

    @State private var selectedTab: TabType = .home
    @State private var onTappedTabTrigger: [TabType: Trigger] = .init(
        uniqueKeysWithValues: TabType.allCases.map { ($0, .init()) }
    )
    @State private var selectedPagerTab: TabLayoutType = .swift

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

    func navigateToSidebar() {
        viewModel.uiState.isPresentedSidebar = true
    }

    func navigateToHome() {
        viewModel.update(state: .loggedIn)
    }

    func navigateToSignUpHome() {
        viewModel.update(state: .loggedOut)
        resetNavigation()
    }

    func resetNavigation() {
        TabType.allCases.forEach { type in
            navigator.nav[type]?.removeAll()
        }
        selectedTab = .home
    }

    func navigate(path: AppNavigation.Path) {
        switch path {
        case .sidebar:
            navigateToSidebar()
        case .signUpHome:
            navigateToSignUpHome()
        case .tabHome:
            navigateToHome()
        default:
            navigator.nav[selectedTab]?.navigate(to: path)
        }
    }

    @ViewBuilder func content(path: AppNavigation.Path) -> some View {
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

// MARK: Initializer

private extension RootScreen {
    func splash() -> some View {
        splashScreen()
    }

    func signUpHome() -> some View {
        signUpHomeScreen(navigate: navigate, content: content)
    }

    func tabHome() -> some View {
        tabHomeScreen(selection: _selectedTab) { tab in
            onTappedTabTrigger[tab]?.invoke()
        } content: { tab in
            switch tab {
            case .home:
                navigationHome()
            case .search:
                navigationSearch()
            }
        }
        .sidebar(
            isPresented: $viewModel.uiState.isPresentedSidebar,
            isTargetSlide: true
        ) {
            sideMenu()
        }
    }

    func tabLayoutHome() -> some View {
        TabLayout(selection: _selectedPagerTab) { tab in
            selectedPagerTab = tab
        } content: { type in
            home(language: type.text)
        }
    }

    func home(language: String) -> some View {
        homeScreen(
            language: language,
            onTappedTabTrigger: onTappedTabTrigger[selectedTab] ?? .init(),
            navigate: navigate
        )
    }

    func setting() -> some View {
        settingScreen(navigate: navigate)
    }

    func search() -> some View {
        searchScreen(navigate: navigate)
    }

    func web(url: String) -> some View {
        webScreen(url)
    }

    func sideMenu() -> some View {
        sideMenuScreen { path in
            viewModel.uiState.isPresentedSidebar = false
            switch path {
            case .search:
                selectedTab = .search
            default:
                navigate(path: path)
            }
        }
    }
}

// MARK: Navigation Top

private extension RootScreen {
    func navigationHome() -> some View {
        NavigationStack(
            path: .init(
                get: { navigator.nav[.home]?.path ?? [] },
                set: { navigator.nav[.home]?.update(path: $0) }
            )
        ) {
            tabLayoutHome()
                .appNavigationDestination(content: content)
        }
    }

    func navigationSearch() -> some View {
        NavigationStack(
            path: .init(
                get: { navigator.nav[.search]?.path ?? [] },
                set: { navigator.nav[.search]?.update(path: $0) }
            )
        ) {
            search()
                .appNavigationDestination(content: content)
        }
    }

    func navigationSignUpHome() -> some View {
        NavigationStack {
            signUpHome()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}
