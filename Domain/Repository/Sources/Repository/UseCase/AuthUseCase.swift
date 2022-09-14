//
//  File.swift
//  
//
//  Created by Yoshiki Hemmi on 2022/09/14.
//

import Foundation
import Combine
import Model

public protocol AuthUseCaseProtcol {
    func login(email: String, password: String) -> AnyPublisher<Void, Error>
}

public final class AuthUseCase: AuthUseCaseProtcol {

    public func login(email: String, password: String) -> AnyPublisher<Void, Error> {
        if (password.count < 6) {
            return Fail(error: AuthError.invalid).eraseToAnyPublisher()
        }
        return Empty().eraseToAnyPublisher()
    }
    
    public init() {}
}
