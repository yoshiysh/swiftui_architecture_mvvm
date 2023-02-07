//
//  Trigger.swift
//  swiftui_architecture_mvvm
//
//  Created by Yoshiki Hemmi on 2023/02/07.
//

import SwiftUI

public struct Trigger: Equatable {
    private(set) var key = false

    public init() {}

    public mutating func invoke() {
        key.toggle()
    }
}

public extension View {
    func onTrigger(of trigger: Trigger, perform: @escaping () -> Void) -> some View {
        onChange(of: trigger.key) { _ in
            perform()
        }
    }
}
