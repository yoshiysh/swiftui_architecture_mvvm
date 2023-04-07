//
//  SearchResponseEntity.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/27.
//

public struct SearchResponseEntity: Equatable, Sendable {
    public let totalCount: Int
    public let items: [RepositoryEntity]
}

extension SearchResponseEntity: Codable {}
