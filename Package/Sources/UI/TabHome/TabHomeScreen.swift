//
//  TabHomeScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/15.
//

import SwiftUI
import UI_Core

public struct TabHomeScreen<Content: View>: View {
    private let content: (TabType) -> Content

    public var body: some View {
        TabView {
            ForEach(0..<TabType.allCases.count, id: \.self) { index in
                let type = TabType.allCases[index]
                content(type)
                    .tabItem {
                        Image(systemName: type.imageName)
                        Text(type.text)
                    }
            }
        }
    }

    public init(@ViewBuilder content: @escaping (TabType) -> Content) {
        self.content = content
    }
}

struct TabHome_Previews: PreviewProvider {
    static var previews: some View {
        TabHomeScreen { _ in }
    }
}
