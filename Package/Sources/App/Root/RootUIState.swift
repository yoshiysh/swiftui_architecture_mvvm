//
//  RootUIState.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/14.
//

struct RootUIState {
    enum State {
        case initialized, loggedOut, loggedIn
    }

    private(set) var state: State = .initialized
}

extension RootUIState {
    mutating func update(state: State) {
        self.state = state
    }
}
