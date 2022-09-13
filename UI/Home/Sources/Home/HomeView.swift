//
//  HomeView.swift
//  swiftui_architecture_mvvm
//
//  Created by Yoshiki Hemmi on 2022/09/13.
//

import SwiftUI

public struct HomeView: View {
    public init() {}
    
    public var body: some View {
        NavigationView {
            Text("Hello Home")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
