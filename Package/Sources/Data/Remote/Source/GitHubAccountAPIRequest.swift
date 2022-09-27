//
//  GitHubAccountAPIRequest.swift
//  
//
//  Created by Yoshiki Hemmi on 2022/09/20.
//

import Foundation
import Domain

struct GitHubAccountAPIRequest: BaseRequestProtocol {
    typealias ResponseType = UserEntity
    
    var method: HTTPMethod = .get
    var path: String = "/users"
    var queryItems: [URLQueryItem] = []
    
    init(userName: String) {
        path += "/\(userName)"
    }
}
