//
//  SearchScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/15.
//

import SwiftUI
import UI_Core

public struct SearchScreen: View {
    enum ActionType {
        case search, web, signOut
    }

    private let navigate: (Navigation.Path) -> Void

    public var body: some View {
        searchView { type in
            switch type {
            case .search:
                navigate(.search)
            case .web:
                navigate(.web(url: "https://github.com/signup"))
            case .signOut:
                navigate(.signUpHome)
            }
        }
        .navigationTitle("Search")
    }

    public init(navigate: @escaping (Navigation.Path) -> Void) {
        self.navigate = navigate
    }
}

private extension View {
    func searchView(action: @escaping (SearchScreen.ActionType) -> Void) -> some View {
        VStack(spacing: 32) {
            transitionSearchButton {
                action(.search)
            }

            transitionWebButton {
                action(.web)
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
            Text("L10n.Button.search")
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .padding()
        }
        .buttonStyle(.borderedProminent)
    }

    func transitionWebButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Text("L10n.Button.web")
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
            Text("L10n.Button.signOut")
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .padding()
        }
        .buttonStyle(.borderedProminent)
    }
}

struct SearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreen { _ in }
    }
}
