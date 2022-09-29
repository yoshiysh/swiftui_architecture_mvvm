//
//  SearchDto.swift
//  
//
//  Created by Yoshiki Hemmi on 2022/09/30.
//

import Foundation

public struct QueryDto {
    public var keyword: String? = nil
    public var language: String? = nil
    public var sortType: SortType? = nil
    public var orderType: OrderType
    public var perPage: Int
    public var page: Int
    
    public init(
        keyword: String? = nil,
        language: String? = nil,
        sortType: SortType? = nil,
        orderType: OrderType = .desc,
        perPage: Int = 10,
        page: Int = 1
    ) {
        self.keyword = keyword
        self.language = language
        self.sortType = sortType
        self.orderType = orderType
        self.perPage = perPage
        self.page = page
    }
}

public extension QueryDto {
    func buildQueryItems() -> [URLQueryItem] {
        var items = [URLQueryItem]([
            .init(name: "order", value: orderType.rawValue),
            .init(name: "per_page", value: "\(perPage)"),
            .init(name: "page", value: "\(page)")
        ])
        var params: [String] = []

        if let sort = sortType {
            params.append("sort:\(sort.rawValue)")
        }
        
        if let language = language, !language.isEmpty {
            params.append("language:\(language)")
        }
        
        let joinedParams = params.joined(separator: "+")

        var q: String
        if let keyword = keyword, !keyword.isEmpty {
            q = "\(keyword)+\(joinedParams)"
        } else {
            q = "\(joinedParams)"
        }
        
        items.append(.init(name: "q", value: q))
        return items
    }
}
