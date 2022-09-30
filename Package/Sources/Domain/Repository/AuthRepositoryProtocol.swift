//
//  AuthRepositoryProtocol.swift
//
//
//  Created by Yoshiki Hemmi on 2022/09/14.
//

import Combine
import Foundation

public protocol AuthRepositoryProtocol {
    func login(email: String, password: String) -> AnyPublisher<Void, Error>
}
