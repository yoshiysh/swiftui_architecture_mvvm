//
//  TabHomeScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by Yoshiki Hemmi on 2022/09/15.
//

import SwiftUI

public struct TabHomeScreen: View {
    
    @StateObject var viewModel: TabHomeViewModel
    
    public var body: some View {
        TabView {
            HomeScreen()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            SearchScreen()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
        }
    }
    
    public init(_ viewModel: TabHomeViewModel? = nil) {
        _viewModel = StateObject(wrappedValue: viewModel ?? .init())
    }
}

struct TabHome_Previews: PreviewProvider {
    static var previews: some View {
        TabHomeScreen()
    }
}
