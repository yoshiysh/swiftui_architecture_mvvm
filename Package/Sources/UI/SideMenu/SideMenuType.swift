//
//  SideMenuType.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2023/02/05.
//

import UI_Core

public enum SideMenuType: CaseIterable {
    case search, setting

    public var imageName: String {
        switch self {
        case .search:
            return "magnifyingglass"
        case .setting:
            return "gearshape.fill"
        }
    }

    public var text: String {
        switch self {
        case .search:
            return "Search"
        case .setting:
            return "Setting"
        }
    }

    public var path: AppNavigation.Path {
        switch self {
        case .search:
            return .search
        case .setting:
            return .setting
        }
    }
}
