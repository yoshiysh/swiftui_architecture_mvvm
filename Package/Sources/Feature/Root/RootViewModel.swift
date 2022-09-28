//
//  RootViewModel.swift
//  swiftui_architecture_mvvm
//
//  Created by Yoshiki Hemmi on 2022/09/14.
//

import Foundation
import Combine

@MainActor
public final class RootViewModel: ObservableObject {
    
    @Published var state: RootScreenState = .initialized
    
    private var cancellables = Set<AnyCancellable>()
    
    func updateState(_ state: RootScreenState) {
        self.state = state
    }
    
    private func getUser() {
        state = .loggedOut
    }
    
    public init() {
        getUser()
    }
}
