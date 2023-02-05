//
//  HomeScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/13.
//

import Domain
import SwiftUI
import UI_Core

enum ToolbarActionType {
    case setting, debug
}

public struct HomeScreen: View {
    @StateObject private var viewModel: HomeViewModel = .init()
    private let navigate: (Navigation.Path) -> Void

    public var body: some View {
        homeView(
            items: viewModel.uiState.items,
            isInitial: viewModel.uiState.isInitial,
            hasNextPage: viewModel.uiState.hasNextPage
        ) {
            Task { await viewModel.next() }
        } onTapItem: {
            debugPrint("item tapped")
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

    public init(navigate: @escaping (Navigation.Path) -> Void) {
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
