//
//  SignUpHomeViewModel.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/14.
//

import Combine

@MainActor
final class SignUpHomeViewModel: ObservableObject {
    @Published var uiState: SignUpHomeUIState = .init()

    func updateState(_ state: SignUpHomeUIState.State) {
        uiState.updateState(state)
    }
}
