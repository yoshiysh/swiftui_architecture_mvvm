//
//  AuthRepositoryImpl.swift
//  
//
//  Created by Yoshiki Hemmi on 2022/09/14.
//

import Foundation
import Combine
import Model
import Repository

public final class AuthRepository: AuthRepositoryProtocol {
    public func login(email: String, password: String) -> AnyPublisher<Void, Error> {
        return Fail(error: AuthError.invalid).eraseToAnyPublisher()
    }
}
