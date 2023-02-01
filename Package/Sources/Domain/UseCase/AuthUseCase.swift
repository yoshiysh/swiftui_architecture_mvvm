//
//  AuthUseCase.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/14.
//

public protocol AuthUseCaseProtcol {
    func validate(email: String, password: String) -> Bool

    func signIn(email: String, password: String) async throws
}

public final class AuthUseCase: AuthUseCaseProtcol {
    public init() {}

    public func validate(email: String, password: String) -> Bool {
        !email.isEmpty && !password.isEmpty
    }

    public func signIn(email: String, password: String) async throws {
        if !validate(email: email, password: password) {
            throw AuthErrorType.invalid
        }
    }
}
