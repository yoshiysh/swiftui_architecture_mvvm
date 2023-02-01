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
    case unknown

    public var errorMessage: String {
        switch self {
        case .networkError(code: _, description: let description):
            return description
        case .decodeError(reason: let reason):
            return reason
        case .irregularError(info: let info):
            return info
        case .finishedWithoutValue, .unknown:
            return "unknown error"
        }
    }
}
