//
//  User.swift
//  
//
//  Created by Yoshiki Hemmi on 2022/09/29.
//

import Foundation

public struct UserModel: Identifiable, Equatable {
    public let login: String
    public let id: Int
    public let avatarUrl: URL
    public let url: URL
    public let reposUrl: URL
    public let followers: Int?
    public let following: Int?
    
    public init(
        login: String,
        id: Int,
        avatarUrl: URL,
        url: URL,
        reposUrl: URL,
        followers: Int?,
        following: Int?
    ) {
        self.login = login
        self.id = id
        self.avatarUrl = avatarUrl
        self.url = url
        self.reposUrl = reposUrl
        self.followers = followers
        self.following = following
    }
}

public extension UserModel {
    static let preview = UserModel(
        login: "yoshi991",
        id: 0,
        avatarUrl: URL(string: "https://avatars.githubusercontent.com/u/22577999?v=4")!,
        url: URL(string: "https://api.github.com/users/yoshi991")!,
        reposUrl: URL(string: "https://api.github.com/users/yoshi991/repos")!,
        followers: 1000,
        following: 1001
    )
}
