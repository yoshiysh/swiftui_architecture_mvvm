//
//  BaseRequestProtocol.swift
//  
//
//  Created by Yoshiki Hemmi on 2022/09/27.
//

import Foundation

protocol BaseRequestProtocol: BaseAPIProtocol {
    var queryItems: [URLQueryItem] { get }
}

extension BaseRequestProtocol {
    func asURLRequest() -> URLRequest {
        let url = baseUrl.appendingPathComponent(path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = queryItems
        
        var urlRequest = URLRequest(url: baseUrl.appendingPathComponent(path))
        urlRequest.url = components?.url
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.timeoutInterval = TimeInterval(30)
        return urlRequest
    }
}
