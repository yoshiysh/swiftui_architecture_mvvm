//
//  RootView.swift
//  swiftui_architecture_mvvm
//
//  Created by Yoshiki Hemmi on 2022/09/13.
//

import SwiftUI

public struct RootView: View {
    public init() {}
    
    public var body: some View {
        NavigationView {
            Text("Hello Root")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
