//
//  UserResponse.swift
//  
//
//  Created by Yoshiki Hemmi on 2022/09/27.
//

public struct UserResponse: Codable {
    var data: [UserModel]
    
    public init(from decoder: Decoder) throws {
        data = try decoder.singleValueContainer().decode([UserModel].self)
    }
}
