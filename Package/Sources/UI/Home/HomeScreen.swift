//
//  HomeScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/13.
//

import Domain
import SwiftUI
import UI_Core
import UI_Setting

public struct HomeScreen: View { // swiftlint:disable:this file_types_order
    @StateObject private var viewModel: HomeViewModel = .init()
    private let onLoggedOut: () -> Void

    public var body: some View {
        NavigationView {
            VStack {
                HomeView(
                    items: viewModel.uiState.items,
                    isInitial: viewModel.uiState.isInitial,
                    hasNextPage: viewModel.uiState.hasNextPage
                ) {
                    Task { await viewModel.next() }
                } onTapItem: {
                    print("item tapped")
                }
                .navigationTitle("Repository")
                .toolbar {
                    HomeToolbar {
                    } onClickDebug: {
                        viewModel.showSnackbar()
                    } onClickSetting: {
                        viewModel.uiState.routeToSetting = true
                    }
                }

                navigationLink
            }
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

    @ViewBuilder
    private var navigationLink: some View {
        NavigationLink(
            destination: SettingScreen(onLoggedOut: onLoggedOut),
            isActive: $viewModel.uiState.routeToSetting
        ) { EmptyView() }
    }

    public init(onLoggedOut: @escaping () -> Void) {
        self.onLoggedOut = onLoggedOut
    }
}

private struct HomeToolbar: ToolbarContent {
    let onClickMenu: () -> Void
    let onClickDebug: () -> Void
    let onClickSetting: () -> Void

    var body: some ToolbarContent {
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

private struct HomeView: View {
    let items: [RepositoryEntity]
    let isInitial: Bool
    let hasNextPage: Bool
    let onAppearLoadingItem: (() -> Void)
    let onTapItem: () -> Void

    var body: some View {
        if isInitial {
            VStack {}
        } else if items.isEmpty {
            ContentsEmptyView()
        } else {
            HomeContentsView(
                items: items,
                hasNextPage: hasNextPage,
                onAppearLoadingItem: onAppearLoadingItem,
                onTapItem: onTapItem
            )
        }
    }
}

private struct HomeContentsView: View {
    let items: [RepositoryEntity]
    let hasNextPage: Bool
    let onAppearLoadingItem: () -> Void
    let onTapItem: () -> Void

    var body: some View {
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
            HomeContentsView(items: [RepositoryEntity.preview], hasNextPage: false) {} onTapItem: {}
        }
    }

    static var previews: some View {
        HomeContentsPreview()
    }
}
