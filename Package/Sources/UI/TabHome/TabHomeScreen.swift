//
//  TabHomeScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/15.
//

import SwiftUI
import UI_Core

public struct TabHomeScreen<Content: View>: View {
    @State private var selection: TabType = .home
    private let current: (TabType) -> Void
    private let content: (TabType) -> Content

    public var body: some View {
        TabView(selection: $selection) {
            ForEach(0..<TabType.allCases.count, id: \.self) { index in
                let type = TabType.allCases[index]
                content(type)
                    .tabItem {
                        Image(systemName: type.imageName)
                        Text(type.text)
                    }
                    .tag(type)
            }
        }
        .onChange(of: selection) { type in
            current(type)
        }
    }

    public init(
        current: @escaping (TabType) -> Void,
        @ViewBuilder content: @escaping (TabType) -> Content
    ) {
        self.current = current
        self.content = content
    }
}

struct TabHome_Previews: PreviewProvider {
    static var previews: some View {
        TabHomeScreen { _ in } content: { _ in }
    }
}
