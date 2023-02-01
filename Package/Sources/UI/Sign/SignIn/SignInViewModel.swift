//
//  SignInViewModel.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/14.
//

import Combine
import Domain
import Foundation

@MainActor
public final class SignInViewModel: ObservableObject {
    @Published var uiState: SignInViewUIState = .init()
    private let useCase: AuthUseCaseProtcol

    public init(_ useCase: AuthUseCaseProtcol = AuthUseCase()) {
        self.useCase = useCase
    }

    func initializeFocusState() async {
        do {
            try await Task.sleep(nanoseconds: 2 * USEC_PER_SEC)
            uiState.initializeFocusState()
        } catch {
            debugPrint("error: \(error)")
        }
    }

    func didTapSubmitButton() {
        uiState.updateNextFocusState()
    }

    func updateSubmitButton() {
        uiState.updateSubmitButton { [weak self] email, password in
            self?.useCase.validate(email: email, password: password) ?? false
        }
    }

    func signIn() async {
        uiState.updateState(.loading)
        uiState.updateSubmitButton(enabled: false)
        do {
            try await withThrowingTaskGroup(of: Void.self) { group in
                group.addTask {
                    try await self.useCase.signIn(email: self.uiState.email, password: self.uiState.password)
                }
                group.addTask {
                    try await Task.sleep(nanoseconds: 1000 * USEC_PER_SEC)
                }
                for try await _ in group {
                }
                uiState.updateState(.suceess)
            }
        } catch {
            debugPrint("error: \(error)")
            uiState.updateState(.error)
        }
    }
}
