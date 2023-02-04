//
//  RootViewModel.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/14.
//

import Combine
import Foundation
import UI_Core

@MainActor
final class RootViewModel: ObservableObject {
    @Published var uiState: RootUIState = .init()

    func getUser() async {
        try? await Task.sleep(nanoseconds: 1_000 * USEC_PER_SEC)
        //        uiState.state = .loggedOut
        uiState.state = .loggedIn
    }

    func update(state: RootUIState.State) {
        uiState.state = state
    }

    func update(currentTab: TabType) {
        uiState.currentTab = currentTab
    }
}
