//
//  HomeDataModel.swift
//
//
//  Created by yoshi on 2022/09/30.
//

import Combine
import Domain

struct HomeDataModel {
    var query: QueryDto
    var items: [RepositoryEntity] = []
    var totalCount: Int = -1
    var hasNextPage: Bool {
        items.count < totalCount
    }

    init(query: QueryDto) {
        self.query = query
    }
}

extension HomeDataModel {
    var isEmpty: Bool {
        items.isEmpty
    }

    func findIndex(item: RepositoryEntity) -> Int {
        items.firstIndex { $0.id == item.id } ?? -1
    }

    mutating func refresh() {
        self.items.removeAll()
        self.totalCount = -1
    }

    mutating func update(data: SearchResponseEntity) {
        data.items.forEach {
            if findIndex(item: $0) > 0 {
                return
            }
            self.items.append($0)
        }
        self.totalCount = data.totalCount
    }
}
