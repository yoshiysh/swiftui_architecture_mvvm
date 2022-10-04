//
//  SignUpScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/14.
//

import SwiftUI

public struct SignUpScreen: View { // swiftlint:disable:this file_types_order

    public var body: some View {
        SignUpView()
    }

    public init() {}
}

private struct SignUpView: View {

    var body: some View {
        WebScreen("https://github.com/signup")
    }
}

struct SignUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreen()
    }
}
