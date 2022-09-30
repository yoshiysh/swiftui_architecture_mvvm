//
//  AuthRepositoryImpl.swift
//
//
//  Created by Yoshiki Hemmi on 2022/09/14.
//

import Combine
import Domain
import Foundation

public final class AuthRepository: AuthRepositoryProtocol {
    public func login(email: String, password: String) -> AnyPublisher<Void, Error> {
        Fail(error: AuthErrorType.invalid).eraseToAnyPublisher()
    }
}
