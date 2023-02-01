//
//  SignInViewUIState.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/14.
//

struct SignInViewUIState {
    enum State {
        case initialzed, loading, suceess, error
    }

    enum FocusState: Hashable {
        case email, password
    }

    private(set) var state: State = .initialzed
    private(set) var focusState: FocusState?

    var email: String = ""
    var password: String = ""
    var isSubmitButtonEnabled = false

    mutating func initializeFocusState() {
        focusState = .email
    }

    mutating func updateNextFocusState() {
        switch focusState {
        case .email:
            self.focusState = .password
        case .password:
            self.focusState = nil
        case nil:
            break
        }
    }

    mutating func updateState(_ state: State) {
        self.state = state
    }

    mutating func updateSubmitButton(enabled: Bool) {
        self.isSubmitButtonEnabled = enabled
    }

    mutating func updateSubmitButton(validator: @escaping ((String, String) -> Bool)) {
        self.isSubmitButtonEnabled = validator(email, password)
    }
}
