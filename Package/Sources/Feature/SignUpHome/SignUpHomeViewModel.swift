//
//  SignUpHomeViewModel.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/14.
//

import Combine
import Foundation

@MainActor
final class SignUpHomeViewModel: ObservableObject {

    @Published private(set) var state: SignUpHomeState = .initialized
    @Published var isShowingSheet = false

    private var cancellables = Set<AnyCancellable>()

    init() {
        startObserver()
    }

    func updateState(_ state: SignUpHomeState) {
        self.state = state
    }

    private func startObserver() {
        $state.sink { [weak self] value in
            self?.isShowingSheet = value == .signIn || value == .signUp
        }
        .store(in: &cancellables)
    }
}
