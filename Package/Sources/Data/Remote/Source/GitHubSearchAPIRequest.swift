//
//  GitHubSearchAPIRequest.swift
//
//
//  Created by yoshi on 2022/09/27.
//

import Domain
import Foundation

struct GitHubSearchAPIRequest: BaseRequestProtocol {
    typealias ResponseType = SearchResponseEntity

    var method: HTTPMethod = .get
    var path: String = "/search/repositories"
    var body: String = ""
    var queryItems: [URLQueryItem] {
        query.buildQueryItems()
    }

    private let query: QueryDto

    init(query: QueryDto) {
        self.query = query
    }
}
