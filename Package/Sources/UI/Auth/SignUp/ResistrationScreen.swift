//
//  SignUpScreen.swift
//  
//
//  Created by Yoshiki Hemmi on 2022/09/14.
//

import SwiftUI

public struct SignUpScreen: View {
    
    public var body: some View {
        SignUpView()
    }
    
    public init() {}
}

private struct SignUpView: View {
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    Text("Hello, Sign Up")
                }
            }
        }
    }
}

struct ResistrationScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreen()
    }
}
