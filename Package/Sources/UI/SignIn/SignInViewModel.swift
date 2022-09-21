//
//  SignInViewModel.swift
//  swiftui_architecture_mvvm
//
//  Created by Yoshiki Hemmi on 2022/09/14.
//

import Foundation
import Combine
import Domain

@MainActor
public final class SignInViewModel: ObservableObject {
    
    @Published private(set) var state: SignInViewState = .initialzed
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isSubmitButtonEnabled: Bool = true
    @Published private(set) var focusState: SignInState? = .email
    
    private let useCase: AuthUseCaseProtcol
    private var cancellables = Set<AnyCancellable>()
    
    var onEmailCommit: PassthroughSubject<Void, Never> = .init()
    var onPasswordCommit: PassthroughSubject<Void, Never> = .init()
    var onCommit: PassthroughSubject<Void, Never> = .init()

    private func startObserver() {
        onEmailCommit
            .sink(receiveValue: { [weak self] value in
                self?.focusState = .password
            })
            .store(in: &cancellables)
        
        onPasswordCommit
            .sink(receiveValue: { [weak self] value in
                self?.focusState = nil
                self?.isSubmitButtonEnabled = true
            })
            .store(in: &cancellables)
        
        onCommit
            .sink(receiveValue: { [weak self] value in
//                self?.fetch()
                self?.updateState(.suceess)
            })
            .store(in: &cancellables)
    }
    
    private func updateState(_ state: SignInViewState) {
        self.state = state
    }
    
    private func fetch() {
        updateState(.loading)
        useCase.login(email: self.email, password: self.password)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    self?.updateState(.error)
                }
            }, receiveValue: { [weak self] value in
                self?.updateState(.suceess)
            })
            .store(in: &cancellables)
    }
    
    public init(_ useCase: AuthUseCaseProtcol = AuthUseCase()) {
        self.useCase = useCase
        startObserver()
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
}
