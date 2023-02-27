//
//  SignUpScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/14.
//

import SwiftUI
import UI_Core

struct SignUpScreen<Content: View>: View {
    private let content: (AppNavigation.Path) -> Content

    var body: some View {
        content(.web(url: "https://github.com/signup"))
    }

    init(@ViewBuilder content: @escaping (AppNavigation.Path) -> Content) {
        self.content = content
    }
}

struct SignUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreen { _ in }
    }
}
