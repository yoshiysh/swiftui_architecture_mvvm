//
//  UserEntity.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/27.
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
        login: "yoshiysh",
        id: 22577999,
        avatarUrl: {
            if let url = URL(string: "https://avatars.githubusercontent.com/u/22577999?v=4") {
                return url
            } else {
                fatalError("Invalid URL.")
            }
        }(),
        url: {
            if let url = URL(string: "https://api.github.com/users/yoshiysh") {
                return url
            } else {
                fatalError("Invalid URL.")
            }
        }(),
        reposUrl: {
            if let url = URL(string: "https://api.github.com/users/yoshiysh/repos") {
                return url
            } else {
                fatalError("Invalid URL.")
            }
        }(),
        followers: 1000,
        following: 1001
    )
}
