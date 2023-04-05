//
//  AuthUseCase.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/14.
//

public protocol AuthUseCase: Sendable { // swiftlint:disable:this file_types_order
    func validate(email: String, password: String) -> Bool

    func signIn(email: String, password: String) async throws
}

public final class AuthDefaultUseCase: AuthUseCase {
    private let repository: any AuthRepository

    public init(repository: some AuthRepository) {
        self.repository = repository
    }

    public func validate(email: String, password: String) -> Bool {
        !email.isEmpty && !password.isEmpty
    }

    public func signIn(email: String, password: String) async throws {
        if !validate(email: email, password: password) {
            throw AuthErrorType.invalid
        }

        await repository.login(email: email, password: password)
    }
}
