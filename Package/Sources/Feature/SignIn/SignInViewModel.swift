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

    @Published private(set) var state: SignInViewState = .initialzed
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isSubmitButtonEnabled = true
    @Published private(set) var focusState: SignInFocusState?

    private let useCase: AuthUseCaseProtcol
    private var cancellables = Set<AnyCancellable>()

    public init(_ useCase: AuthUseCaseProtcol = AuthUseCase()) {
        self.useCase = useCase
        startObserver()
    }

    func initializeFocusState() {
        focusState = .email
    }

    public func didTapSubmitButton() {
        switch focusState {
        case .email:
            focusState = .password
        case .password:
            focusState = nil
        case nil:
            break
        }
    }

    public func onCommit() {
        fetch()
    }

    private func updateViewState(_ state: SignInViewState) {
        self.state = state
    }

    private func startObserver() {
        $email.sink { [weak self] _ in
            self?.updateSubmitButton()
        }
        .store(in: &cancellables)

        $password.sink { [weak self] _ in
            self?.updateSubmitButton()
        }
        .store(in: &cancellables)
    }

    private func fetch() {
        updateViewState(.loading)
        useCase.signIn(email: self.email, password: self.password)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    self?.updateViewState(.suceess) // FIXME:
                }
            }, receiveValue: { [weak self] _ in
                self?.updateViewState(.suceess)
            })
            .store(in: &cancellables)
    }

    private func updateSubmitButton() {
        isSubmitButtonEnabled = useCase.validate(email: email, password: password)
    }
}
