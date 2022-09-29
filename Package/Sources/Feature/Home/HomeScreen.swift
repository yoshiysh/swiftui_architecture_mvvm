//
//  HomeScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by Yoshiki Hemmi on 2022/09/13.
//

import SwiftUI
import Domain

public struct HomeScreen: View {
   
    @StateObject private var viewModel: HomeViewModel = .init()
    
    public var body: some View {
        NavigationView {
            HomeView(viewModel: viewModel)
                .navigationTitle("Repository")
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
        switch viewModel.state {
        case .suceess(let data):
            if data.isEmpty {
                HomeEmptyView()
            } else {
                HomeContentsView(items: data.items)
            }
        default:
            EmptyView()
        }
    }
}

private struct HomeContentsView: View {
    
    @State var items: [RepositoryEntity]
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack {
                ForEach(items) { item in
                    RepositoryCardView(item: binding(for: item))
                }
            }
            .padding()
        }
    }
    
    private func binding(for model: RepositoryEntity) -> Binding<RepositoryEntity> {
        Binding<RepositoryEntity> {
            guard let index = items.firstIndex(where: { $0.id == model.id }) else {
                fatalError()
            }
            return items[index]
        } set: { newValue in
            guard let index = items.firstIndex(where: { $0.id == model.id }) else {
                fatalError()
            }
            return items[index] = newValue
        }
    }
}

private struct HomeEmptyView: View {
    
    var body: some View {
        Text("Contents is Empty")
    }
}

struct HomeScreen_Previews: PreviewProvider {
    private struct HomeContentsPreview: View {
        @State private var model = [RepositoryEntity.preview]
        
        var body: some View {
            HomeContentsView(items: model)
        }
    }
    
    static var previews: some View {
        Group {
            HomeContentsPreview()
            HomeEmptyView()
        }
    }
}
