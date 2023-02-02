//
//  HomeScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/13.
//

import Domain
import SwiftUI
import UI_Core
import UI_Search
import UI_Setting

public struct HomeScreen: View {
    @StateObject private var viewModel: HomeViewModel = .init()
    private let onLoggedOut: () -> Void

    public var body: some View {
        NavigationStack(path: $viewModel.uiState.navigationPath) {
            homeView(
                items: viewModel.uiState.items,
                isInitial: viewModel.uiState.isInitial,
                hasNextPage: viewModel.uiState.hasNextPage
            ) {
                Task { await viewModel.next() }
            } onTapItem: {
                debugPrint("item tapped")
            }
            .homeNavigationDestination {
                viewModel.navigate(to: .search)
            } navigateToLoggedOut: {
                onLoggedOut()
            }
            .homeToolbar {
                debugPrint("menu tapped")
            } onClickDebug: {
                viewModel.showSnackbar()
            } onClickSetting: {
                viewModel.navigate(to: .setting)
            }
            .navigationTitle("Repository")
        }
        .snackbar(
            isPresented: $viewModel.uiState.isShowingAlert,
            message: viewModel.uiState.alertMessage
        ) {
            Button {
                viewModel.uiState.isShowingAlert = false
            } label: {
                Image(systemName: "xmark.circle")
            }
        }
        .refreshable {
            await viewModel.refresh()
        }
        .task {
            await viewModel.fetch()
        }
    }

    public init(onLoggedOut: @escaping () -> Void) {
        self.onLoggedOut = onLoggedOut
    }
}

private extension View {
    func homeToolbar(
        onClickMenu: @escaping () -> Void,
        onClickDebug: @escaping () -> Void,
        onClickSetting: @escaping () -> Void
    ) -> some View {
        toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    onClickMenu()
                } label: {
                    Image(systemName: "line.3.horizontal")
                }
            }

            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    onClickDebug()
                } label: {
                    Image(systemName: "exclamationmark.circle")
                }
                Button {
                    onClickSetting()
                } label: {
                    Image(systemName: "gearshape.fill")
                }
            }
        }
    }

    func homeNavigationDestination(
        navigateToSearch: @escaping () -> Void,
        navigateToLoggedOut: @escaping () -> Void
    ) -> some View {
        navigationDestination(for: HomeUIState.Navigator.self) { path in
            switch path {
            case .setting:
                SettingScreen(onClickSearch: navigateToSearch, onClickLoggedOut: navigateToLoggedOut)
            case .search:
                SearchScreen()
            }
        }
    }

    func homeView(
        items: [RepositoryEntity],
        isInitial: Bool,
        hasNextPage: Bool,
        onAppearLoadingItem: @escaping () -> Void,
        onTapItem: @escaping () -> Void
    ) -> some View {
        Group {
            if isInitial {
                VStack {}
            } else if items.isEmpty {
                ContentsEmptyView()
            } else {
                homeContentsView(
                    items: items,
                    hasNextPage: hasNextPage,
                    onAppearLoadingItem: onAppearLoadingItem,
                    onTapItem: onTapItem
                )
            }
        }
    }

    func homeContentsView(
        items: [RepositoryEntity],
        hasNextPage: Bool,
        onAppearLoadingItem: @escaping () -> Void,
        onTapItem: @escaping () -> Void
    ) -> some View {
        ScrollView(.vertical) {
            LazyVStack {
                ForEach(items, id: \.id) { item in
                    RepositoryCardView(
                        item: item,
                        onTapGesture: onTapItem
                    )
                    .frame(maxWidth: .infinity)
                }

                if hasNextPage {
                    LoadingView()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .task { onAppearLoadingItem() }
                }
            }
            .padding()
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    private struct HomeContentsPreview: View {
        var body: some View {
            homeContentsView(items: [RepositoryEntity.preview], hasNextPage: false) {} onTapItem: {}
        }
    }

    static var previews: some View {
        HomeContentsPreview()
    }
}
