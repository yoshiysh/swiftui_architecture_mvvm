//
//  TabHomeScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/15.
//

import SwiftUI
import UI_Home
import UI_Search

public struct TabHomeScreen: View {
    @StateObject private var viewModel: TabHomeViewModel = .init()

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

    public init() {}
}

struct TabHome_Previews: PreviewProvider {
    static var previews: some View {
        TabHomeScreen()
    }
}
