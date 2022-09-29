//
//  Publisher+.swift
//  
//
//  Created by Yoshiki Hemmi on 2022/09/28.
//

import Foundation
import Combine

extension Publisher {
    
    public func sink(
        scheduler: DispatchQueue,
        success: @escaping (Self.Output) -> Void,
        failure: @escaping (Self.Failure) -> Void,
        completion: @escaping () -> Void = {}
    ) -> AnyCancellable {
        return self
            .receive(on: scheduler)
            .sink(success: success, failure: failure, completion: completion)
    }
    
    public func sink(
        success: @escaping (Self.Output) -> Void,
        failure: @escaping (Self.Failure) -> Void,
        completion: @escaping () -> Void = {}
    ) -> AnyCancellable {
        return self
            .sink(receiveCompletion: { result in
                switch result {
                case .finished: break
                case .failure(let error): failure(error)
                }
                completion()
            }, receiveValue: success)
    }
 }
