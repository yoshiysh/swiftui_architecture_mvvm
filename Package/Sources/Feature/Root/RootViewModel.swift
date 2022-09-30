//
//  RootViewModel.swift
//  swiftui_architecture_mvvm
//
//  Created by Yoshiki Hemmi on 2022/09/14.
//

import Combine
import Foundation

@MainActor
public final class RootViewModel: ObservableObject {

    @Published var state: RootViewState = .initialized

    private var cancellables = Set<AnyCancellable>()

    public init() {
        getUser()
    }

    func updateState(_ state: RootViewState) {
        self.state = state
    }

    private func getUser() {
        state = .loggedOut
    }
}
