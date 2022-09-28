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
    @Published private(set) var focusState: SignInFocusState? = nil
    
    private let useCase: AuthUseCaseProtcol
    private var cancellables = Set<AnyCancellable>()
    
    var onEmailCommit: PassthroughSubject<Void, Never> = .init()
    var onPasswordCommit: PassthroughSubject<Void, Never> = .init()
    var onCommit: PassthroughSubject<Void, Never> = .init()

    func updateFocusState(_ state: SignInFocusState?) {
        focusState = state
    }
    
    private func updateViewState(_ state: SignInViewState) {
        self.state = state
    }
    
    private func startObserver() {
        onEmailCommit
            .sink(receiveValue: { [weak self] value in
                self?.updateFocusState(.password)
            })
            .store(in: &cancellables)
        
        onPasswordCommit
            .sink(receiveValue: { [weak self] value in
                self?.updateFocusState(nil)
                self?.isSubmitButtonEnabled = true
            })
            .store(in: &cancellables)
        
        onCommit
            .sink(receiveValue: { [weak self] value in
//                self?.fetch()
                self?.updateViewState(.suceess)
            })
            .store(in: &cancellables)
    }
    
    private func fetch() {
        updateViewState(.loading)
        useCase.login(email: self.email, password: self.password)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    self?.updateViewState(.error)
                }
            }, receiveValue: { [weak self] value in
                self?.updateViewState(.suceess)
            })
            .store(in: &cancellables)
    }
    
    public init(_ useCase: AuthUseCaseProtcol = AuthUseCase()) {
        self.useCase = useCase
        startObserver()
    }
}
