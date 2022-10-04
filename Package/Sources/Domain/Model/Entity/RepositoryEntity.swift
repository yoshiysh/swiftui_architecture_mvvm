//
//  RepositoryEntity.swift
//
//
//  Created by yoshi on 2022/09/27.
//

import Foundation

public struct RepositoryEntity: Equatable, Identifiable {
    public let id: Int
    public let name: String
    public let fullName: String
    public let owner: UserEntity
    public let htmlUrl: URL
    public let description: String?
    public let language: String?
    public let stargazersCount: Int
    public let updatedAt: Date
}

extension RepositoryEntity: Codable {}

public extension RepositoryEntity {
    static let preview = RepositoryEntity(
        id: 0,
        name: "GLSample4iOS",
        fullName: "yoshi991/GLSample4iOS",
        owner: .preview,
        htmlUrl: {
            if let url = URL(string: "https://github.com/yoshi991/GLSample4iOS") {
                return url
            } else {
                fatalError("Invalid URL.")
            }
        }(),
        description: "decription",
        language: "Swift",
        stargazersCount: 1000,
        updatedAt: Date()
    )
}
