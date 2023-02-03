//
//  View+.swift
//  swiftui_architecture_mvvm
//
//  Created by Yoshiki Hemmi on 2023/02/03.
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
