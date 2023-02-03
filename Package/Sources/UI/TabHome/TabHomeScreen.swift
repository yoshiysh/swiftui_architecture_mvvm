//
//  TabHomeScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/15.
//

import SwiftUI
import UI_Core

public struct TabHomeScreen<Content: View>: View {
    public enum Tab {
        case home, search
    }

    private let content: (Tab) -> Content

    public var body: some View {
        TabView {
            content(.home)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            content(.search)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
        }
    }

    public init(@ViewBuilder content: @escaping (Tab) -> Content) {
        self.content = content
    }
}

struct TabHome_Previews: PreviewProvider {
    static var previews: some View {
        TabHomeScreen { _ in }
    }
}
