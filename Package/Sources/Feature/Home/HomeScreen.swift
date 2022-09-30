//
//  HomeScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by Yoshiki Hemmi on 2022/09/13.
//

import Domain
import SwiftUI

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
                items: $viewModel.data.items,
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

    @Binding var items: [RepositoryEntity]
    @State var hasNextPage = true
    var onAppearLoadingItem: (() -> Void)

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack {
                ForEach(items, id: \.id) { item in
                    RepositoryCardView(item: binding(for: item))
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

    private func binding(for model: RepositoryEntity) -> Binding<RepositoryEntity> {
        Binding<RepositoryEntity> {
            guard let index = items.firstIndex(where: { $0.id == model.id }) else {
                fatalError("Index Out of Bounds Exception.")
            }
            return items[index]
        } set: { newValue in
            guard let index = items.firstIndex(where: { $0.id == model.id }) else {
                fatalError("Index Out of Bounds Exception.")
            }
            return items[index] = newValue
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    private struct HomeContentsPreview: View {
        @State private var model = [RepositoryEntity.preview]

        var body: some View {
            HomeContentsView(items: $model) {}
        }
    }

    static var previews: some View {
        HomeContentsPreview()
    }
}
