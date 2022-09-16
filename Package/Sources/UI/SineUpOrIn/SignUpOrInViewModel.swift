//
//  SignUpOrInViewModel.swift
//  swiftui_architecture_mvvm
//
//  Created by Yoshiki Hemmi on 2022/09/14.
//

import Foundation
import Combine

public final class SignUpOrInViewModel: ObservableObject {
    
    public init() {        
        self.$state.sink(
            receiveCompletion: { _ in
            },
            receiveValue: { [weak self] value in
                switch(value) {
                case .signIn, .signUp:
                    self?.isShowingSheet = true
                default:
                    self?.isShowingSheet = false
                }
            }
        )
        .store(in: &cancellables)
    }
    
    @Published private(set) var state: SignUpOrInState? = nil
    @Published var isShowingSheet: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func updateState(_ state: SignUpOrInState) {
        self.state = state
    }
}
