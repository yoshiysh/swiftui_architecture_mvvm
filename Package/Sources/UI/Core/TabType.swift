//
//  TabType.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2023/02/03.
//

public enum TabType: CaseIterable {
    case home, search

    public var imageName: String {
        switch self {
        case .home:
            return "house"
        case .search:
            return "magnifyingglass"
        }
    }

    public var text: String {
        switch self {
        case .home:
            return "Home"
        case .search:
            return "Search"
        }
    }
}
