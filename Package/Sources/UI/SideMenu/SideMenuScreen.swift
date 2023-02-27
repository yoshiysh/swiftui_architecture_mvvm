//
//  SideMenuScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2023/02/05.
//

import SwiftUI
import UI_Core

public func sideMenuScreen(navigate: @escaping (AppNavigation.Path) -> Void) -> some View {
    SideMenuScreen(navigate: navigate)
}

struct SideMenuScreen: View {
    private let navigate: (AppNavigation.Path) -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Divider()
                ForEach(0..<SideMenuType.allCases.count, id: \.self) { index in
                    let type = SideMenuType.allCases[index]
                    Label(type.text, systemImage: type.imageName)
                        .foregroundColor(.white)
                        .onTapGesture {
                            navigate(type.path)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Divider()
                }
            }
            .padding(.top, 96)
            .padding(.horizontal, 24)
        }
    }

    init(navigate: @escaping (AppNavigation.Path) -> Void) {
        self.navigate = navigate
    }
}
