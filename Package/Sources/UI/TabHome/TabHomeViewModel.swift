//
//  TabHomeViewModel.swift
//  swiftui_architecture_mvvm
//
//  Created by Yoshiki Hemmi on 2022/09/21.
//

import Foundation
import Combine

@MainActor
public final class TabHomeViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    
    public init() {}
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
}
