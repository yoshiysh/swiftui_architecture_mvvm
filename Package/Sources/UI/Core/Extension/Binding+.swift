//
//  Binding+.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2023/02/07.
//

import SwiftUI

public extension Binding {
    func willSet(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        .init(
            get: { wrappedValue },
            set: { newValue in
                handler(newValue)
                wrappedValue = newValue
            }
        )
    }
}
