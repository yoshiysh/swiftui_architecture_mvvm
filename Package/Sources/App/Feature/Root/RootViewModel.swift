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

    @Published var state: RootViewState = .initialized

    private var cancellables = Set<AnyCancellable>()

    init() {
        getUser()
    }

    func updateState(_ state: RootViewState) {
        self.state = state
    }

    private func getUser() {
        state = .loggedOut
    }
}
