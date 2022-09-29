//
//  UserEntity.swift
//  
//
//  Created by Yoshiki Hemmi on 2022/09/27.
//

import Foundation

public struct UserEntity: Equatable {
    public let login: String
    public let id: Int
    public let avatarUrl: URL
    public let url: URL
    public let reposUrl: URL
    public let followers: Int?
    public let following: Int?
}

extension UserEntity: Codable {}

public extension UserEntity {
    static let preview = UserEntity(
        login: "yoshi991",
        id: 22577999,
        avatarUrl: URL(string: "https://avatars.githubusercontent.com/u/22577999?v=4")!,
        url: URL(string: "https://api.github.com/users/yoshi991")!,
        reposUrl: URL(string: "https://api.github.com/users/yoshi991/repos")!,
        followers: 1000,
        following: 1001
    )
}
