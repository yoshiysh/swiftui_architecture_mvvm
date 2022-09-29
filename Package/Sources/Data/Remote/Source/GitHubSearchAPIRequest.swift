//
//  GitHubSearchAPIRequest.swift
//  
//
//  Created by Yoshiki Hemmi on 2022/09/27.
//

import Foundation
import Domain

struct GitHubSearchAPIRequest: BaseRequestProtocol {
    typealias ResponseType = SearchResponseEntity
    
    var method: HTTPMethod = .get
    var path: String = "/search/repositories"
    var body: String = ""
    var queryItems: [URLQueryItem] {
        query.buildQueryItems()
    }
    
    private let query: QueryDto

    public init(query: QueryDto) {
        self.query = query
    }
}
