//
//  RootViewModel.swift
//  swiftui_architecture_mvvm
//
//  Created by Yoshiki Hemmi on 2022/09/14.
//

import Foundation
import Combine

public final class RootViewModel: ObservableObject {
    
    static let shared: RootViewModel = .init()
    
    public init() {}
    
    @Published var state: RootScreenState = .initialized
    
    private var cancellables = Set<AnyCancellable>()
    
    func onAppear() {
        getUser()
    }
    
    func onDisappear() {
        cancellables.forEach { $0.cancel() }
    }
    
    private func getUser() {
        if state != .initialized { return }
        Task { @MainActor in
            state = .loggedOut
        }
    }
}
