//
//  GitHubAccountAPIRequest.swift
//
//
//  Created by yoshi on 2022/09/20.
//

import Domain
import Foundation

struct GitHubAccountAPIRequest: BaseRequestProtocol {
    typealias ResponseType = UserEntity

    var method: HTTPMethod = .get
    var path: String = "/users"
    var body: String = ""
    var queryItems: [URLQueryItem] = []

    init(userName: String) {
        path += "/\(userName)"
    }
}
