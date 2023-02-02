//
//  SignUpScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/14.
//

import SwiftUI
import UI_Web

public struct SignUpScreen: View {
    public var body: some View {
        signUpView()
    }

    public init() {}
}

private extension View {
    func signUpView() -> some View {
        WebScreen("https://github.com/signup")
    }
}

struct SignUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreen()
    }
}
