//
//  ApiClient.swift
//  
//
//  Created by Yoshiki Hemmi on 2022/09/27.
//

import Foundation
import Domain

struct ApiClient {
    private static let successRange = 200..<300
    private static let session = URLSession.shared
    private static let decoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
    
    static func call<T, V>(_ request: T) async throws -> V
        where T: BaseRequestProtocol, V: Codable, T.ResponseType == V {
        
        let result = try await session.data(for: request.asURLRequest())
        let data = try validate(data: result.0, response: result.1)
        return try decoder.decode(V.self, from: data)
    }
    
    static func validate(data: Data, response: URLResponse) throws -> Data {
        guard let code = (response as? HTTPURLResponse)?.statusCode else {
            throw NetworkError.networkError(code: -1, description: String(data: data, encoding: .utf8) ?? "Network Error")
        }
        guard successRange.contains(code) else {
            throw NetworkError.networkError(code: code, description: "out of statusCode range")
        }
        return data
    }
    
    static func validateCode(data: Data, response: URLResponse) throws -> Data {
        switch (response as? HTTPURLResponse)?.statusCode {
        case .some(let code) where code == 401:
            throw NetworkError.networkError(code: code, description: "Unauthorized")
        case .some(let code) where code == 404:
            throw NetworkError.networkError(code: code, description: "Not Found")
        case .none:
            throw NetworkError.irregularError(info: "Irregular Error")
        case .some:
            return data
        }
    }
}
