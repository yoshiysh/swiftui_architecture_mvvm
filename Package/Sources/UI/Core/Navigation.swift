//
//  Navigation.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2023/02/03.
//

public protocol Navigation {
    associatedtype Path: Hashable
    var path: [Self.Path] { get set }
}

public extension Navigation {
    mutating func update(path: [Path]) {
        self.path = path
    }

    mutating func navigate(
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

    mutating func pop() {
        path.removeLast()
    }

    mutating func removeAll() {
        path.removeAll()
    }

    mutating func removeAll(path: Path) {
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
        var new: [Path] = []
        new.append(path)
        update(path: new)
    }
}
