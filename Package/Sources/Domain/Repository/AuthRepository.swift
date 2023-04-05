//
//  AuthRepository.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/14.
//

import Combine

public protocol AuthRepository: Sendable {
    func login(email: String, password: String) async
}
