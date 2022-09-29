//
//  RepositoryModel.swift
//  
//
//  Created by Yoshiki Hemmi on 2022/09/29.
//

import Foundation

public struct RepositoryModel: Identifiable, Equatable {
    public let id: Int
    public let name: String
    public let fullName: String
    public let owner: UserModel
    public let htmlUrl: URL
    public let description: String?
    public let language: String?
    public let stargazersCount: Int
    
    public init(
        id: Int,
        name: String,
        fullName: String,
        owner: UserModel,
        htmlUrl: URL,
        description: String?,
        language: String?,
        stargazersCount: Int
    ) {
        self.id = id
        self.name = name
        self.fullName = fullName
        self.owner = owner
        self.htmlUrl = htmlUrl
        self.description = description
        self.language = language
        self.stargazersCount = stargazersCount
    }
}

public extension RepositoryModel {
    static let preview = RepositoryModel(
        id: 0,
        name: "yoshi991",
        fullName: "yoshi",
        owner: .preview,
        htmlUrl: URL(string: "https://api.github.com/users/yoshi991")!,
        description: "decription",
        language: "Swift",
        stargazersCount: 1000
    )
}
