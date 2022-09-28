//
//  UserEntity.swift
//  
//
//  Created by Yoshiki Hemmi on 2022/09/27.
//

import Foundation

public struct UserEntity: Codable {
    public let login: String
    public let id: Int
    public let avatarUrl: URL
    public let url: URL
    public let reposUrl: String
    public let followers: Int?
    public let following: Int?
}
