//
//  RepositoryEntity.swift
//  
//
//  Created by Yoshiki Hemmi on 2022/09/27.
//

import Foundation

public struct RepositoryEntity: Codable {
    let id: Int
    let name: String
    let fullName: String
    let owner: UserEntity
    let htmlUrl: URL
    let description: String?
    let language: String?
    let stargazersCount: Int
    
    public func convertItem() -> RepositoryModel {
        RepositoryModel(
            id: id,
            name: name,
            fullName: fullName,
            owner: owner.convertItem(),
            htmlUrl: htmlUrl,
            description: description,
            language: language,
            stargazersCount: stargazersCount)
    }
}
