//
//  SettingScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2023/02/02.
//

import SwiftUI

public struct SettingScreen: View { // swiftlint:disable:this file_types_order
    private let onClickSearch: () -> Void
    private let onClickLoggedOut: () -> Void

    public var body: some View {
        SettingView(
            onClickSearch: onClickSearch,
            onClickLoggedOut: onClickLoggedOut
        )
        .navigationTitle("Setting")
    }

    public init(
        onClickSearch: @escaping () -> Void,
        onClickLoggedOut: @escaping () -> Void
    ) {
        self.onClickSearch = onClickSearch
        self.onClickLoggedOut = onClickLoggedOut
    }
}

private struct SettingView: View {
    let onClickSearch: () -> Void
    let onClickLoggedOut: () -> Void

    var body: some View {
        VStack {
            TransitionSearchButton(action: onClickSearch)
            SignOutButton(action: onClickLoggedOut)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
    }
}

private struct TransitionSearchButton: View {
    let action: () -> Void

    var body: some View {
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
}

private struct SignOutButton: View {
    let action: () -> Void

    var body: some View {
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
        SettingScreen {
        } onClickLoggedOut: {
        }
    }
}
