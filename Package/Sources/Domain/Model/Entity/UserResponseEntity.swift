//
//  UserResponseEntity.swift
//  
//
//  Created by Yoshiki Hemmi on 2022/09/27.
//

public struct UserResponseEntity: Equatable {
    public let data: [UserEntity]
}

extension UserResponseEntity: Codable {}
