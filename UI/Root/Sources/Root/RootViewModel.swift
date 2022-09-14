//
//  File.swift
//  
//
//  Created by Yoshiki Hemmi on 2022/09/14.
//

import Foundation

public final class RootViewModel: ObservableObject {
    public init() {
        state = .loading
        getUser()
    }
    
    @Published var state: RootScreenState
    
    func getUser() {
        state = .loggedOut
    }
}
