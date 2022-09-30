//
//  SignUpHomeViewModel.swift
//  swiftui_architecture_mvvm
//
//  Created by Yoshiki Hemmi on 2022/09/14.
//

import Combine
import Foundation

@MainActor
public final class SignUpHomeViewModel: ObservableObject {

    @Published private(set) var state: SignUpHomeState = .initialized
    @Published var isShowingSheet = false

    private var cancellables = Set<AnyCancellable>()

    public init() {
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
