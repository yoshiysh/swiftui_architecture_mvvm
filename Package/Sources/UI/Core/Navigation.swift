//
//  Navigation.swift
//  swiftui_architecture_mvvm
//
//  Created by Yoshiki Hemmi on 2023/02/03.
//

import Combine

public struct Navigation { // swiftlint:disable:this file_types_order
    public enum Path: Hashable {
        case home, search, setting, signUpHome, splash
    }
    public var path: [Path] = []
}

@MainActor
public final class Navigator: ObservableObject {
    public static let shared: Navigator = .init()

    @Published public var navigation: Navigation = .init()

    public func navigate(
        to path: Navigation.Path,
        pop: Bool = false,
        removeAll: Bool = false
    ) {
        navigation.path.append(path)
    }

    public func navigateToRoot() {
        navigation.path.removeAll()
    }

    public func pop() -> Navigation.Path? {
        navigation.path.popLast()
    }

    public func removeAll() {
        navigation.path.removeAll()
    }

    public func removeAll(path: Navigation.Path) {
        navigation.path.removeAll { path == $0 }
    }

    func navigateWithPop(to path: Navigation.Path) {
        var new = navigation.path
        if new.isEmpty {
            return
        }
        new.removeLast()
        new.append(path)
        navigation.path = new
    }

    func navigationWithRemoveAll(to path: Navigation.Path) {
        var new: [Navigation.Path] = []
        new.append(path)
        navigation.path = new
    }
}
