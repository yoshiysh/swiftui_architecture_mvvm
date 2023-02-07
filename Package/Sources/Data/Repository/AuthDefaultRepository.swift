//
//  AuthDefaultRepository.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/14.
//

import Combine
import Domain
import Foundation

public final class AuthDefaultRepository {
    public init() {}
}

extension AuthDefaultRepository: AuthRepository {
    public func login(email: String, password: String) async {
        try? await Task.sleep(nanoseconds: 1_000 * USEC_PER_SEC)
    }
}
