//
//  File.swift
//  
//
//  Created by Yoshiki Hemmi on 2022/09/14.
//

import Foundation
import Combine

public protocol AuthUseCaseProtcol {
    func emailValidater(email: String) -> Bool
    
    func login(email: String, password: String) -> AnyPublisher<Void, Error>
}

public final class AuthUseCase: AuthUseCaseProtcol {
    
    public func emailValidater(email: String) -> Bool {
        let range = 6...12
        return range.contains(email.count)
    }

    public func login(email: String, password: String) -> AnyPublisher<Void, Error> {
        if (emailValidater(email: email)) {
            return Fail(error: AuthErrorType.invalid).eraseToAnyPublisher()
        }
        return Fail(error: AuthErrorType.invalid).eraseToAnyPublisher()
    }
    
    public init() {}
}
