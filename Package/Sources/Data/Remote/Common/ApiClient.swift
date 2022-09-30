//
//  ApiClient.swift
//
//
//  Created by Yoshiki Hemmi on 2022/09/27.
//

import Combine
import Domain
import Foundation

struct ApiClient {
    private static let timeout: Double = 30
    private static let successRange = 200..<300
    private static let retryCount: Int = 1
    private static let session = URLSession.shared
    private static let decoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .iso8601
        return jsonDecoder
    }()

    static func call<T, V>(_ request: T) async throws -> V where T: BaseRequestProtocol, V: Codable, T.ResponseType == V {
        var req = request.asURLRequest()
        req.timeoutInterval = TimeInterval(timeout)
        //        debugPrint("[ApiClient] request: \(req)")
        let response = try await session.data(for: req)
        //        debugPrint("[ApiClient] response: \(response)")

        let data = try validate(data: response.0, response: response.1)
        return try decoder.decode(V.self, from: data)
    }

    static func publish<T, V>(_ request: T) -> AnyPublisher<V, NetworkErrorType> where T: BaseRequestProtocol, V: Codable, T.ResponseType == V {
        session
            .dataTaskPublisher(for: request.asURLRequest())
            .timeout(.seconds(timeout), scheduler: DispatchQueue.main)
            .retry(retryCount)
            .validate(statusCode: successRange)
            .decode(type: V.self, decoder: decoder)
            .mapDecodeError()
            .eraseToAnyPublisher()
    }

    private static func validate(data: Data, response: URLResponse) throws -> Data {
        guard let code = (response as? HTTPURLResponse)?.statusCode else {
            throw NetworkErrorType.networkError(code: -1, description: String(data: data, encoding: .utf8) ?? "Network Error")
        }
        guard successRange.contains(code) else {
            throw NetworkErrorType.networkError(code: code, description: "Out of status code range")
        }
        return data
    }

    private static func validateCode(data: Data, response: URLResponse) throws -> Data {
        switch (response as? HTTPURLResponse)?.statusCode {
        case .some(let code) where code == 401:
            throw NetworkErrorType.networkError(code: code, description: "Unauthorized")
        case .some(let code) where code == 404:
            throw NetworkErrorType.networkError(code: code, description: "Not Found")
        case .none:
            throw NetworkErrorType.irregularError(info: "Irregular Error")
        case .some:
            return data
        }
    }
}
