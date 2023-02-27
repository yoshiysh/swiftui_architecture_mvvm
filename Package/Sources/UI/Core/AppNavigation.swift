//
//  AppNavigation.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2023/02/28.
//

import Combine

public struct AppNavigation: Navigation { // swiftlint:disable:this file_types_order
    public typealias Path = Self.Paths

    public enum Paths: Hashable {
        case home, search, setting, signUpHome, splash, tabHome
        case web(url: String)
        case sidebar
    }
    public var path: [Path] = []
}

public final class Navigator: ObservableObject {
    @Published public var nav: [TabType: AppNavigation] = [:]

    public init() {
        TabType.allCases.forEach { type in
            nav[type] = .init()
        }
    }
}
