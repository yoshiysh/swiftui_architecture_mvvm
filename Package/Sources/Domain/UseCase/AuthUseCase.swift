//
//  AuthUseCase.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/14.
//

import Combine
import Foundation

public protocol AuthUseCaseProtcol {
    func validate(email: String, password: String) -> Bool

    func signIn(email: String, password: String) -> AnyPublisher<Void, Error>
}

public final class AuthUseCase: AuthUseCaseProtcol {
    public init() {}

    public func validate(email: String, password: String) -> Bool {
        !email.isEmpty && !password.isEmpty
    }

    public func signIn(email: String, password: String) -> AnyPublisher<Void, Error> {
        if validate(email: email, password: password) {
            return Fail(error: AuthErrorType.invalid).eraseToAnyPublisher()
        }
        return Fail(error: AuthErrorType.invalid).eraseToAnyPublisher()
    }
}
