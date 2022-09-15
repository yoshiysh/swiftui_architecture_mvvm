//
//  SignUpOrInViewModel.swift
//  
//
//  Created by Yoshiki Hemmi on 2022/09/14.
//

import Foundation
import Combine
import UICore

public final class SignUpOrInViewModel: ViewModelObject {
    
    public let input: Input
    @BindableObject public var binding: Binding
    public let output: Output
    
    private var cancellables = Set<AnyCancellable>()
    
    public func updateState(_ state: SignUpOrInState) {
        output.state = state
        
        switch(output.state) {
        case .signIn, .signUp:
            binding.isShowingSheet = true
        default:
            binding.isShowingSheet = false
        }
    }
    
    final public class Input: InputObject {
        public var onLoad: PassthroughSubject<Void, Never> = .init()

        public init() {}
    }

    final public class Binding: BindingObject {
        @Published public var isShowingSheet: Bool = false

        public init() {}
    }

    final public class Output: OutputObject {
        @Published public var state: SignUpOrInState? = nil

        public init() {}
    }
    
    public init(
        input: Input = .init(),
        binding: BindableObject<Binding> = .init(.init()),
        output: Output = .init()
    ) {
        self.input = input
        self._binding = binding
        self.output = output
    }
}
