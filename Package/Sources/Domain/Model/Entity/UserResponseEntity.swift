//
//  UserResponseEntity.swift
//
//
//  Created by yoshi on 2022/09/27.
//

public struct UserResponseEntity: Equatable {
    public let data: [UserEntity]
}

extension UserResponseEntity: Codable {}
