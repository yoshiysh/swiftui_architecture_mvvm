//
//  ResistrationScreen.swift
//  
//
//  Created by Yoshiki Hemmi on 2022/09/14.
//

import SwiftUI

public struct ResistrationScreen: View {
    
    public var body: some View {
        RegistrationView()
    }
    
    public init() {}
}

private struct RegistrationView: View {
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    Text("Hello, Resistration")
                }
            }
        }
    }
}

struct ResistrationScreen_Previews: PreviewProvider {
    static var previews: some View {
        ResistrationScreen()
    }
}
