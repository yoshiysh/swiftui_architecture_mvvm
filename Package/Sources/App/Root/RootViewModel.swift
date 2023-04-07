//
//  RootViewModel.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/14.
//

import Combine
import DI
import Foundation
import UI_Core

@MainActor
final class RootViewModel: ObservableObject {
    @Published var uiState: RootUIState = .init()

    var component: some RepositoryProtocol = rootComponent.repository

    func getUser() async {
        try? await Task.sleep(nanoseconds: 1_000 * USEC_PER_SEC)
        //        uiState.state = .loggedOut
        uiState.state = .loggedIn
        print("point = \(component.getPoint())")
    }

    func update(state: RootUIState.State) {
        uiState.state = state
    }
}
