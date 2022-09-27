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
        var items = [URLQueryItem]([
            .init(name: "sort", value: "stars"),
            .init(name: "order", value: "desc")
        ])
        var params: [String] = []

        if let language = language, !language.isEmpty {
            params.append("language:\(language)")
        }

        if let hasStars = hasStars, hasStars > 0 {
            params.append("stars:>=\(hasStars)")
        }

        if let topic = topic, !topic.isEmpty {
            params.append("topic:\(topic)")
        }

        let joinedParams = params.joined(separator: "+")

        var q = ""
        if let keyword = keyword, !keyword.isEmpty {
            q = "\(keyword)+\(joinedParams)"
        } else {
            q = joinedParams
        }
        
        items.append(.init(name: "q", value: q))
        return items
    }
    
    private let keyword: String?
    private let language: String?
    private let hasStars: Int?
    private let topic: String?

    public init(
        keyword: String? = nil,
        language: String? = nil,
        hasStars: Int? = nil,
        topic: String? = nil
    ) {
        self.language = language
        self.keyword = (keyword?.isEmpty ?? true) ? "" : keyword
        self.hasStars = hasStars
        self.topic = (topic?.isEmpty ?? true) ? "" : topic
    }
}
