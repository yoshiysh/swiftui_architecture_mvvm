//
//  GitHubAccountAPIRequest.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/20.
//

import Domain
import Foundation

public struct GitHubAccountAPIRequest: BaseRequestProtocol {
    public typealias ResponseType = UserEntity

    public var method: HTTPMethod = .get
    public var path: String = "/users"
    public var body: String = ""
    public var queryItems: [URLQueryItem] = []

    public init(userName: String) {
        path += "/\(userName)"
    }
}
