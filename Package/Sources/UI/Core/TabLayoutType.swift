//
//  TabLayoutType.swift
//  swiftui_architecture_mvvm
//
//  Created by Yoshiki Hemmi on 2023/02/08.
//

public enum TabLayoutType: CaseIterable {
    case swift, kotlin, dart, go

    public var text: String {
        switch self {
        case .swift:
            return "swift"
        case .kotlin:
            return "kotlin"
        case .dart:
            return "dart"
        case .go:
            return "go"
        }
    }
}
