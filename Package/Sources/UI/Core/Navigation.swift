//
//  Navigation.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2023/02/03.
//

import Combine

public struct Navigation { // swiftlint:disable:this file_types_order
    public enum Path: Hashable {
        case home, search, setting, signUpHome, splash, tabHome
        case web(url: String)
        case sidebar
    }
    public private(set) var path: [Path] = []

    public mutating func update(path: [Path]) {
        self.path = path
    }

    public mutating func navigate(
        to path: Path,
        pop: Bool = false,
        removeAll: Bool = false
    ) {
        if pop {
            navigateWithPop(to: path)
        } else if removeAll {
            navigationWithRemoveAll(to: path)
        } else {
            self.path.append(path)
        }
    }

    public mutating func pop() {
        path.removeLast()
    }

    public mutating func removeAll() {
        path.removeAll()
    }

    public mutating func removeAll(path: Path) {
        self.path.removeAll { path == $0 }
    }

    mutating func navigateWithPop(to path: Path) {
        var new = self.path
        if new.isEmpty {
            return
        }
        new.removeLast()
        new.append(path)
        update(path: new)
    }

    mutating func navigationWithRemoveAll(to path: Path) {
        var new: [Navigation.Path] = []
        new.append(path)
        update(path: new)
    }
}

public final class Navigator: ObservableObject {
    @Published public var nav: [TabType: Navigation] = [:]

    public init() {
        TabType.allCases.forEach { type in
            nav[type] = .init()
        }
    }
}
