//
//  Publisher+.swift
//
//
//  Created by yoshi on 2022/09/28.
//

import Combine
import Foundation

extension Publisher {

    public func sink(
        scheduler: DispatchQueue,
        success: @escaping (Self.Output) -> Void,
        failure: @escaping (Self.Failure) -> Void,
        completion: @escaping () -> Void = {}
    ) -> AnyCancellable {
        self
            .receive(on: scheduler)
            .sink(success: success, failure: failure, completion: completion)
    }

    public func sink(
        success: @escaping (Self.Output) -> Void,
        failure: @escaping (Self.Failure) -> Void,
        completion: @escaping () -> Void = {}
    ) -> AnyCancellable {
        self
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    failure(error)
                }
                completion()
            }, receiveValue: success)
    }
}
