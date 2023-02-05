//
//  SideMenuScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2023/02/05.
//

import SwiftUI
import UI_Core

public struct SideMenuScreen: View {
    private let navigate: (Navigation.Path) -> Void

    public var body: some View {
        VStack(spacing: 32) {
            ForEach(0..<SideMenuType.allCases.count, id: \.self) { index in
                let type = SideMenuType.allCases[index]
                Label(type.text, systemImage: type.imageName)
                    .foregroundColor(.white)
                    .onTapGesture {
                        navigate(type.path)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }

    public init(navigate: @escaping (Navigation.Path) -> Void) {
        self.navigate = navigate
    }
}
