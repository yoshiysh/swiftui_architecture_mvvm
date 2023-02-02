//
//  SettingScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2023/02/02.
//

import SwiftUI

public struct SettingScreen: View { // swiftlint:disable:this file_types_order
    private let onLoggedOut: () -> Void

    public var body: some View {
        SettingView(action: onLoggedOut)
    }

    public init(onLoggedOut: @escaping () -> Void) {
        self.onLoggedOut = onLoggedOut
    }
}

private struct SettingView: View {
    let action: () -> Void

    var body: some View {
        SignOutButton(action: action)
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.horizontal)
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
        SettingScreen {}
    }
}
