//
//  Publisher+.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/27.
//

import Combine
import Domain
import Foundation

public extension Publisher {
    func validate<T>(statusCode range: T) -> Publishers.TryMap<Self, Data> where T: Sequence, T.Iterator.Element == Int {
        tryMap {
            guard let output = $0 as? (Data, HTTPURLResponse) else {
                throw NetworkErrorType.irregularError(info: "Irregular error")
            }
            guard range.contains(output.1.statusCode) else {
                throw NetworkErrorType.networkError(code: output.1.statusCode, description: "Out of status code range")
            }
            return output.0
        }
    }

    func mapDecodeError() -> Publishers.MapError<Self, NetworkErrorType> {
        mapError {
            switch $0 as? DecodingError {
            case .keyNotFound(_, let context):
                return .decodeError(reason: context.debugDescription)
            default:
                return .decodeError(reason: $0.localizedDescription)
            }
        }
    }
}
