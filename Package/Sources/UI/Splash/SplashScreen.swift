//
//  SplashScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/14.
//

import SwiftUI

public struct SplashScreen: View {
    public var body: some View {
        Text("Hello, SplashScreen")
            .foregroundColor(.primary)
            .statusBarHidden()
    }

    public init() {}
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
