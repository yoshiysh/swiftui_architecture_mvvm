//
//  HomeScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/13.
//

import Domain
import SwiftUI
import UI_Core

@MainActor
public func homeScreen(
    language: String,
    onTappedTabTrigger: Trigger,
    navigate: @escaping (AppNavigation.Path) -> Void
) -> some View {
    HomeScreen(language: language, onTappedTabTrigger: onTappedTabTrigger, navigate: navigate)
}

enum ToolbarActionType {
    case setting, debug
}

struct HomeScreen: View {
    @StateObject private var viewModel: HomeViewModel

    private let onTappedTabTrigger: Trigger
    private let navigate: (AppNavigation.Path) -> Void

    var body: some View {
        homeView(
            items: viewModel.uiState.items,
            isInitial: viewModel.uiState.isInitial,
            hasNextPage: viewModel.uiState.hasNextPage,
            onTappedTabTrigger: onTappedTabTrigger
        ) {
            Task { await viewModel.next() }
        } onTapItem: {
            debugPrint("item tapped")
        } onTapMenuButton: { icon in
            switch icon {
            case .searcch:
                navigate(.search)
            case .setting:
                navigate(.setting)
            default:
                break
            }
        }
        .homeToolbar { type in
            switch type {
            case .setting:
                navigate(.setting)
            case .debug:
                viewModel.showSnackbar()
            }
        }
        .navigationTitle("Repository")
        .navigationBarTitleDisplayMode(.inline)
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
        .onDisappear {
            viewModel.uiState.isShowingAlert = false
        }
        .refreshable {
            await viewModel.refresh()
        }
        .task {
            await viewModel.fetch()
        }
    }

    init(
        language: String,
        onTappedTabTrigger: Trigger,
        navigate: @escaping (AppNavigation.Path) -> Void
    ) {
        _viewModel = StateObject(wrappedValue: .init(language: language))
        self.onTappedTabTrigger = onTappedTabTrigger
        self.navigate = navigate
    }
}

private extension View {
    func homeToolbar(action: @escaping (ToolbarActionType) -> Void) -> some View {
        toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    action(.debug)
                } label: {
                    Image(systemName: "exclamationmark.circle")
                }
            }

            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    action(.setting)
                } label: {
                    Image(systemName: "gearshape.fill")
                }
            }
        }
    }

    func homeView( // swiftlint:disable:this function_parameter_count
        items: [RepositoryEntity],
        isInitial: Bool,
        hasNextPage: Bool,
        onTappedTabTrigger: Trigger,
        onAppearLoadingItem: @Sendable @escaping () -> Void,
        onTapItem: @escaping () -> Void,
        onTapMenuButton: @escaping (MenuIcon) -> Void
    ) -> some View {
        ZStack {
            Group {
                if isInitial {
                    VStack {}
                } else if items.isEmpty {
                    ContentsEmptyView()
                } else {
                    homeContentsView(
                        items: items,
                        hasNextPage: hasNextPage,
                        onTappedTabTrigger: onTappedTabTrigger,
                        onAppearLoadingItem: onAppearLoadingItem,
                        onTapItem: onTapItem
                    )
                }
            }

            LiquidMenuButtons { type in
                onTapMenuButton(type)
            }
        }
    }

    func homeContentsView(
        items: [RepositoryEntity],
        hasNextPage: Bool,
        onTappedTabTrigger: Trigger,
        onAppearLoadingItem: @Sendable @escaping () -> Void,
        onTapItem: @escaping () -> Void
    ) -> some View {
        ScrollViewReader { proxy in
            ScrollView {
                EmptyView().id(0)

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
            .scrollToTop(id: 0, trigger: onTappedTabTrigger, proxy: proxy)
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    private struct HomeContentsPreview: View {
        var body: some View {
            homeContentsView(
                items: [RepositoryEntity.preview],
                hasNextPage: false,
                onTappedTabTrigger: .init()
            ) {
            } onTapItem: {
            }
        }
    }

    static var previews: some View {
        HomeContentsPreview()
    }
}
