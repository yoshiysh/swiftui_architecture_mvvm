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
    private let onTappedTab: (TabType) -> Void
    private let content: (TabType) -> Content

    public var body: some View {
        TabView(selection: $selection.willSet { onTappedTab($0) }) {
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
    }

    public init(
        selection: State<TabType>,
        onTappedTab: @escaping (TabType) -> Void,
        @ViewBuilder content: @escaping (TabType) -> Content
    ) {
        _selection = selection
        self.onTappedTab = onTappedTab
        self.content = content
    }
}

struct TabHomeScreen_Previews: PreviewProvider {
    private struct TabHomeScreenPreview: View {
        @State var selection: TabType = .home

        var body: some View {
            TabHomeScreen(selection: _selection) { _ in } content: { _ in }
        }
    }

    static var previews: some View {
        TabHomeScreenPreview()
    }
}
