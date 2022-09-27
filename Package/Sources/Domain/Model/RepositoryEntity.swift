//
//  RepositoryEntity.swift
//  
//
//  Created by Yoshiki Hemmi on 2022/09/27.
//

import Foundation

public struct RepositoryEntity: Codable {
    public let id: Int
    public let name: String
    public let fullName: String
    public let owner: OwnerEntity
    public let htmlUrl: URL
    public let description: String?
    public let language: String?
    public let stargazersCount: Int
}
