//
//  RootViewModel.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/14.
//

import Combine
import Foundation

@MainActor
final class RootViewModel: ObservableObject {
    @Published var uiState: RootUIState = .init()

    func getUser() async {
        try? await Task.sleep(nanoseconds: 100 * USEC_PER_SEC)
//        uiState.update(state: .loggedOut)
        uiState.update(state: .loggedIn)
    }

    func update(state: RootUIState.State) {
        uiState.update(state: state)
    }
}
