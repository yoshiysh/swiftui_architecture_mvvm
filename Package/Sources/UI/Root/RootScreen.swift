//
//  RootScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by Yoshiki Hemmi on 2022/09/13.
//

import SwiftUI

public struct RootScreen: View {
    
    public init() {}
    
    @StateObject var viewModel: RootViewModel = .shared
    
    public var body: some View {
        switch(viewModel.state) {
        case .initialized:
            SplashScreen()
                .onAppear { viewModel.onAppear() }
                .onDisappear { viewModel.onDisappear() }
        case .loggedOut:
            SignUpOrInScreen()
        case .loggedIn:
            TabHomeScreen()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}
