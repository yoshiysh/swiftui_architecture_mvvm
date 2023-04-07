//
//  SplashScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/14.
//

import SwiftUI

@MainActor
public func splashScreen() -> some View {
    SplashScreen()
}

struct SplashScreen: View {
    var body: some View {
        Text("Hello, SplashScreen")
            .foregroundColor(.primary)
            .statusBarHidden()
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
