//
//  MenuIcon.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2023/02/08.
//

import Foundation

public enum MenuIcon: CaseIterable {
    case menu, house, searcch, setting

    var imageName: String {
        switch self {
        case .menu:
            return "xmark"
        case .house:
            return "house"
        case .searcch:
            return "magnifyingglass"
        case .setting:
            return "gear"
        }
    }

    var diameter: CGFloat {
        switch self {
        case .menu:
            return 72
        default:
            return 64
        }
    }

    var iconSize: CGFloat {
        24
    }
}
