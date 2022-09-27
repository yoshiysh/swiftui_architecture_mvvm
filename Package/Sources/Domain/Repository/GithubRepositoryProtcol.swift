//
//  GithubRepositoryProtcol.swift
//  
//
//  Created by Yoshiki Hemmi on 2022/09/27.
//

public protocol GithubRepositoryProtcol {
    func fetchUser(userName: String) async throws -> UserModel
}
