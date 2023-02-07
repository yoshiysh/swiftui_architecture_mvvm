//
//  View+.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2023/02/03.
//

import SwiftUI

public extension View {
    func appNavigationDestination<Content: View>(
        @ViewBuilder content: @escaping (Navigation.Path) -> Content
    ) -> some View {
        navigationDestination(for: Navigation.Path.self) { path in
            content(path)
        }
    }
}

// MARK: ScrollViewProxy

public extension View {
    func scrollToTop<T: Hashable>(id: T, trigger: Trigger, proxy: ScrollViewProxy) -> some View {
        onChange(of: trigger) { _ in
            withAnimation {
                proxy.scrollTo(id, anchor: .top)
            }
        }
    }
}
