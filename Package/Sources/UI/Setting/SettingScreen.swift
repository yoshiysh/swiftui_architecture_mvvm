//
//  SettingScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2023/02/02.
//

import SwiftUI

public struct SettingScreen: View {
    private let onClickLoggedOut: () -> Void
    private let onClickSearch: () -> Void

    @MainActor public var body: some View {
        settingView {
            onClickLoggedOut()
        } onClickSearch: {
            onClickSearch()
        }
        .navigationTitle("Setting")
    }

    public init(
        onClickLoggedOut: @escaping () -> Void,
        onClickSearch: @escaping () -> Void
    ) {
        self.onClickLoggedOut = onClickLoggedOut
        self.onClickSearch = onClickSearch
    }
}

private extension View {
    func settingView(
        onClickLoggedOut: @escaping () -> Void,
        onClickSearch: @escaping () -> Void
    ) -> some View {
        VStack {
            transitionSearchButton(action: onClickSearch)
            signOutButton(action: onClickLoggedOut)
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
        SettingScreen {} onClickSearch: {}
    }
}
