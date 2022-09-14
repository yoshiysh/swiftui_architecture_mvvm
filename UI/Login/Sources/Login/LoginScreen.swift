//
//  LoginScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by Yoshiki Hemmi on 2022/09/13.
//

import SwiftUI

public struct LoginScreen: View {
    public init() {}
    
    public var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    Spacer()
                    
                    Button {
                        // TODO: Action
                    } label: {
                        Text("ログイン")
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                            .padding(.all)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.blue, lineWidth: 2)
                            )
                            .padding(.horizontal)
                    }
                    
                    Spacer().frame(height: 24)
                    
                    Button {
                        // TODO: Action
                    } label: {
                        Text("新規登録")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.all)
                            .background(.blue)
                            .cornerRadius(6)
                            .padding(.horizontal)
                    }
                    
                    Spacer()
                        .frame(maxWidth: .infinity)
                        .frame(height: geometry.safeAreaInsets.bottom)
                }
            }
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
