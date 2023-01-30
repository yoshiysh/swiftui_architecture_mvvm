//
//  NetworkErrorType.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/27.
//

public enum NetworkErrorType: Error, Equatable {
    case networkError(code: Int, description: String)
    case decodeError(reason: String)
    case irregularError(info: String)
    case finishedWithoutValue
}
