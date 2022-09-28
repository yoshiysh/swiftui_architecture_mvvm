//
//  SignUpHomeViewModel.swift
//  swiftui_architecture_mvvm
//
//  Created by Yoshiki Hemmi on 2022/09/14.
//

import Foundation
import Combine

@MainActor
public final class SignUpHomeViewModel: ObservableObject {
    
    @Published private(set) var state: SignUpHomeState = .initialized
    @Published var isShowingSheet: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func updateState(_ state: SignUpHomeState) {
        self.state = state
    }
    
    private func startObserver() {
        $state.sink(receiveValue: { [weak self] value in
            self?.isShowingSheet = value == .signIn || value == .signUp
        })
        .store(in: &cancellables)
    }
    
    public init() {
        startObserver()
    }
}
