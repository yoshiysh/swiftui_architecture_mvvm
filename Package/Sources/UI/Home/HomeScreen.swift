//
//  HomeScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by Yoshiki Hemmi on 2022/09/13.
//

import SwiftUI

public struct HomeScreen: View {
    
    public var body: some View {
        NavigationView {
            Text("Hello Home")
        }
    }
    
    public init() {}
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
