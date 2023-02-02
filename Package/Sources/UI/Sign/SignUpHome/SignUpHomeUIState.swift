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

    enum ActiveSheet: String, Identifiable {
        case signUp, signIn
        var id: String {
            self.rawValue
        }
    }

    private(set) var state: State = .initialized {
        didSet {
            switch state {
            case .signIn:
                activeSheet = .signIn
            case .signUp:
                activeSheet = .signUp
            default:
                activeSheet = nil
            }
        }
    }
    var activeSheet: ActiveSheet?

    mutating func update(state: State) {
        self.state = state
    }
}
