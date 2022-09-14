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
    public init(viewModel: RootViewModel) {
        self.viewModel = viewModel
    }
    
    @ObservedObject var viewModel: RootViewModel
    
    public var body: some View {
        switch(viewModel.state) {
        case .loading:
            SplashScreen()
        case .loggedOut:
            LoginScreen()
        case .loggedIn:
            HomeScreen()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen(viewModel: RootViewModel())
    }
}
