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
    public let updateAt: Date
    
    public init(
        id: Int,
        name: String,
        fullName: String,
        owner: UserModel,
        htmlUrl: URL,
        description: String?,
        language: String?,
        stargazersCount: Int,
        updatedAt: Date
    ) {
        self.id = id
        self.name = name
        self.fullName = fullName
        self.owner = owner
        self.htmlUrl = htmlUrl
        self.description = description
        self.language = language
        self.stargazersCount = stargazersCount
        self.updateAt = updatedAt
    }
}

public extension RepositoryModel {
    static let preview = RepositoryModel(
        id: 0,
        name: "GLSample4iOS",
        fullName: "yoshi991/GLSample4iOS",
        owner: .preview,
        htmlUrl: URL(string: "https://github.com/yoshi991/GLSample4iOS")!,
        description: "decription",
        language: "Swift",
        stargazersCount: 1000,
        updatedAt: Date()
    )
}
