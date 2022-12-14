//
//  RootScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/13.
//

import SwiftUI

public struct RootScreen: View {

    @StateObject private var viewModel: RootViewModel = .init()

    public var body: some View {
        switch viewModel.state {
        case .initialized:
            SplashScreen()
        case .loggedOut:
            SignUpHomeScreen { viewModel.updateState(.loggedIn) }
        case .loggedIn:
            TabHomeScreen()
        }
    }

    public init() {}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}
