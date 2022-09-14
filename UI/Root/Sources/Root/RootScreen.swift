//
//  RootScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by Yoshiki Hemmi on 2022/09/13.
//

import SwiftUI
import Login
import Home

public struct RootScreen: View {
    @ObservedObject var rootViewModel: RootViewModel
    
    public var body: some View {
        switch(rootViewModel.state) {
        case .loading:
            SplashScreen()
        case .loggedOut:
            LoginOrRegistrationScreen()
        case .loggedIn:
            HomeScreen()
        }
    }
    
    public init(_ viewModel: RootViewModel = RootViewModel()) {
        self.rootViewModel = viewModel
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}
