//
//  SignInViewModel.swift
//  
//
//  Created by Yoshiki Hemmi on 2022/09/14.
//

import Foundation
import Combine
import Domain

public final class SignInViewModel: ViewModelObject {
 
    public let input: Input
    @BindableObject public var binding: Binding
    public let output: Output
    private let useCase: AuthUseCaseProtcol
    private var cancellables = Set<AnyCancellable>()
    
    private func startObserver() {
        input.onEmailCommit
            .sink(receiveCompletion: { _ in
            }, receiveValue: { [weak self] value in
                self?.binding.focusState = .password
            })
            .store(in: &cancellables)
        
        input.onPasswordCommit
            .sink(receiveCompletion: { _ in
            }, receiveValue: { [weak self] value in
                self?.binding.focusState = nil
                self?.binding.isSubmitButtonEnabled = true
            })
            .store(in: &cancellables)
        
        input.onCommit
            .handleEvents(receiveSubscription: { [weak self] value in
                self?.output.state = .loading
            })
            .flatMap { _ in
                self.useCase.login(email: self.binding.email, password: self.binding.password)
            }
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    self?.binding.isSubmitButtonEnabled = false
                    self?.output.state = .suceess
                }
            }, receiveValue: { [weak self] value in
                self?.output.state = .suceess
            })
            .store(in: &cancellables)
    }
    
    final public class Input: InputObject {
        public var onEmailCommit: PassthroughSubject<Void, Never> = .init()
        public var onPasswordCommit: PassthroughSubject<Void, Never> = .init()
        public var onCommit: PassthroughSubject<Void, Never> = .init()

        public init() {}
    }

    final public class Binding: BindingObject {
        @Published public var email: String = ""
        @Published public var password: String = ""
        @Published public var isSubmitButtonEnabled: Bool = true
        @Published public var focusState: SignInState? = .email

        public init() {}
    }

    final public class Output: OutputObject {
        @Published public var state: SignInViewState = .initialzed

        public init() {}
    }
    
    public init(
        input: Input = .init(),
        binding: BindableObject<Binding> = .init(.init()),
        output: Output = .init(),
        useCase: AuthUseCaseProtcol = AuthUseCase()
    ) {
        self.input = input
        self._binding = binding
        self.output = output
        self.useCase = useCase
        
        startObserver()
    }
}
