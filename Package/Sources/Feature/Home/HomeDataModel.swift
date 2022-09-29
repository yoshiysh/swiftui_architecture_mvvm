//
//  HomeDataModel.swift
//  
//
//  Created by Yoshiki Hemmi on 2022/09/30.
//

import Domain

public struct HomeDataModel: Equatable {
    public var items: [RepositoryEntity]
    public var totalCount: Int = -1
    public var query: QueryDto = QueryDto(keyword: "swift")
    public var hasNextPage: Bool {
        items.count >= totalCount
    }
    
    public init(items: [RepositoryEntity] = []) {
        self.items = items
    }
}

public extension HomeDataModel {
    var isEmpty: Bool {
        items.isEmpty
    }
    
    mutating func refresh() {
        self.items.removeAll()
        self.totalCount = -1
    }
    
    mutating func append(items: [RepositoryEntity]) {
        items.forEach { self.items.append($0) }
    }
}
