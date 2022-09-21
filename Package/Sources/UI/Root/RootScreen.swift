//
//  RootScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by Yoshiki Hemmi on 2022/09/13.
//

import SwiftUI

public struct RootScreen: View {
    
    @StateObject var viewModel: RootViewModel
    
    public var body: some View {
        switch(viewModel.state) {
        case .initialized:
            SplashScreen()
        case .loggedOut:
            SignUpHomeScreen() { viewModel.updateState(.loggedIn) }
        case .loggedIn:
            TabHomeScreen()
        }
    }
    
    
    public init(_ viewModel: RootViewModel? = nil) {
        _viewModel = StateObject(wrappedValue: viewModel ?? .init())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}
