//
//  SignUpHomeUIState.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/14.
//

struct SignUpHomeUIState {
    enum State {
        case initialized, signUp, signIn, loggedIn
    }

    private(set) var state: State = .initialized {
        didSet {
            self.isShowingSheet = state == .signIn || state == .signUp
        }
    }
    var isShowingSheet = false

    mutating func updateState(_ state: State) {
        self.state = state
    }
}
