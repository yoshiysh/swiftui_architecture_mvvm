//
//  TabHomeScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/15.
//

import SwiftUI

struct TabHomeScreen: View {

    @StateObject private var viewModel: TabHomeViewModel = .init()

    var body: some View {
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
}

struct TabHome_Previews: PreviewProvider {
    static var previews: some View {
        TabHomeScreen()
    }
}
