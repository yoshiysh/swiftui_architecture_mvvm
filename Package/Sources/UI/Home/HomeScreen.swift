//
//  HomeScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/13.
//

import Domain
import SwiftUI
import UI_Core

public struct HomeScreen: View { // swiftlint:disable:this file_types_order
    @StateObject private var viewModel: HomeViewModel = .init()

    public var body: some View {
        NavigationView {
            HomeView(viewModel: viewModel)
                .navigationTitle("Repository")
        }
        .refreshable {
            Task {
                await viewModel.refresh()
            }
        }
        .onAppear {
            Task {
                await viewModel.fetch()
            }
        }
    }

    public init() {}
}

private struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        if viewModel.data.isEmpty {
            ContentsEmptyView()
        } else {
            HomeContentsView(
                items: viewModel.data.items,
                hasNextPage: viewModel.data.hasNextPage
            ) {
                Task {
                    await viewModel.next()
                }
            }
        }
    }
}

private struct HomeContentsView: View {
    var items: [RepositoryEntity]
    @State var hasNextPage = true
    var onAppearLoadingItem: (() -> Void)

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack {
                ForEach(items, id: \.id) { item in
                    RepositoryCardView(item: item)
                        .frame(maxWidth: .infinity)
                }

                if hasNextPage {
                    LoadingView()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .onAppear { onAppearLoadingItem() }
                }
            }
            .padding()
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    private struct HomeContentsPreview: View {
        var body: some View {
            HomeContentsView(items: [RepositoryEntity.preview]) {}
        }
    }

    static var previews: some View {
        HomeContentsPreview()
    }
}
