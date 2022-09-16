//
//  SignInViewModel.swift
//  swiftui_architecture_mvvm
//
//  Created by Yoshiki Hemmi on 2022/09/14.
//

import Foundation
import Combine
import Domain

public final class SignInViewModel: ObservableObject {
    
    static let shared: SignInViewModel = .init()
        
    public init(
        _ useCase: AuthUseCaseProtcol = AuthUseCase()
    ) {
        self.useCase = useCase
    }
    
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
    
    func onAppear() {
        startObserver()
    }
    
    func onDisappear() {
        cancellables.forEach { $0.cancel() }
    }

    private func startObserver() {
        onEmailCommit
            .sink(receiveCompletion: { _ in
            }, receiveValue: { [weak self] value in
                self?.focusState = .password
            })
            .store(in: &cancellables)
        
        onPasswordCommit
            .sink(receiveCompletion: { _ in
            }, receiveValue: { [weak self] value in
                self?.focusState = nil
                self?.isSubmitButtonEnabled = true
            })
            .store(in: &cancellables)
        
        onCommit
            .handleEvents(receiveSubscription: { [weak self] value in
                self?.state = .loading
            })
            .flatMap { _ in
                self.useCase.login(email: self.email, password: self.password)
            }
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    self?.isSubmitButtonEnabled = false
                    self?.state = .suceess
                }
            }, receiveValue: { [weak self] value in
                self?.state = .suceess
            })
            .store(in: &cancellables)
    }
}
