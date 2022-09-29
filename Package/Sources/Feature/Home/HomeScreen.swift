//
//  HomeScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by Yoshiki Hemmi on 2022/09/13.
//

import SwiftUI

public struct HomeScreen: View {
   
    @StateObject private var viewModel: HomeViewModel = .init()
    
    public var body: some View {
        NavigationView {
            HomeView(viewModel: viewModel)
                .navigationTitle("Repositories")
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
                HomeContentsView()
            }
        default:
            HomeEmptyView()
        }
    }
}

private struct HomeContentsView: View {
    
    var body: some View {
        Text("Contents")
    }
}

private struct HomeEmptyView: View {
    
    var body: some View {
        Text("Contents is Empty")
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
