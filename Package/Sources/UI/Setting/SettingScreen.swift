//
//  SettingScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2023/02/02.
//

import SwiftUI
import UI_Core

public struct SettingScreen: View {
    enum ActionType {
        case search, signOut
    }

    private let navigate: (Navigation.Path) -> Void

    public var body: some View {
        settingView { type in
            switch type {
            case .search:
                navigate(.search)
            case .signOut:
                navigate(.signUpHome)
            }
        }
        .navigationTitle("Setting")
    }

    public init(navigate: @escaping (Navigation.Path) -> Void) {
        self.navigate = navigate
    }
}

private extension View {
    func settingView(action: @escaping (SettingScreen.ActionType) -> Void) -> some View {
        VStack(spacing: 32) {
            transitionSearchButton {
                action(.search)
            }

            signOutButton {
                action(.signOut)
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
    }

    func transitionSearchButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Text(L10n.Button.search)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .padding()
        }
        .buttonStyle(.borderedProminent)
    }

    func signOutButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Text(L10n.Button.signOut)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .padding()
        }
        .buttonStyle(.borderedProminent)
    }
}

struct SettingScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingScreen { _ in }
    }
}
