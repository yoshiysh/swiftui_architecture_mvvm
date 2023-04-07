//
//  RootComponent.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2023/04/07.
//

import NeedleFoundation

public let rootComponent = RootComponent()

public final class RootComponent: BootstrapComponent {
    var point: Int {
        100
    }

    var repository: some RepositoryProtocol {
        RepositoryComponent(parent: self)
    }

    override internal init() {
    }
}

public protocol RepositoryDependency: Dependency {
    var point: Int { get }
}

public protocol RepositoryProtocol {
    func getPoint() -> Int
}

public class RepositoryComponent: Component<RepositoryDependency> {
}

extension RepositoryComponent: RepositoryProtocol {
    public func getPoint() -> Int { dependency.point }
}
