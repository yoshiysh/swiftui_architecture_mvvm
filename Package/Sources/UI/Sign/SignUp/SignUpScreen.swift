//
//  SignUpScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/14.
//

import SwiftUI
import UI_Core

public struct SignUpScreen<Content: View>: View {
    private let content: (Navigation.Path) -> Content

    public var body: some View {
//        content(.web(url: "https://github.com/signup"))
        EmptyView()
    }

    public init(@ViewBuilder content: @escaping (Navigation.Path) -> Content) {
        self.content = content
    }
}

struct SignUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreen { _ in }
    }
}
