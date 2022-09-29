//
//  UserEntity.swift
//  
//
//  Created by Yoshiki Hemmi on 2022/09/27.
//

import Foundation

public struct UserEntity: Codable {
    let login: String
    let id: Int
    let avatarUrl: URL
    let url: URL
    let reposUrl: URL
    let followers: Int?
    let following: Int?
    
    public func convertItem() -> UserModel {
        UserModel(
            login: login,
            id: id,
            avatarUrl: avatarUrl,
            url: url,
            reposUrl: reposUrl,
            followers: followers,
            following: following)
    }
}
