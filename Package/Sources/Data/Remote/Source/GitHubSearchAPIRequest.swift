//
//  GitHubSearchAPIRequest.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/27.
//

import Domain
import Foundation

public struct GitHubSearchAPIRequest: BaseRequestProtocol {
    public typealias ResponseType = SearchResponseEntity

    public var method: HTTPMethod = .get
    public var path: String = "/search/repositories"
    public var body: String = ""
    public var queryItems: [URLQueryItem] {
        query.buildQueryItems()
    }

    private let query: QueryDto

    public init(query: QueryDto) {
        self.query = query
    }
}
