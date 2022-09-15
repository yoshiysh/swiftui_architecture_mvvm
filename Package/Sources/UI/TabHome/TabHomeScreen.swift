//
//  TabHomeScreen.swift
//  
//
//  Created by Yoshiki Hemmi on 2022/09/15.
//

import SwiftUI

public struct TabHomeScreen: View {
    
    public var body: some View {
        TabHomeView()
    }
    
    public init() {}
}

private struct TabHomeView: View {
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
