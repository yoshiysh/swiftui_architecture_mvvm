//
//  GithubRepository.swift
//  
//
//  Created by Yoshiki Hemmi on 2022/09/27.
//

import Domain

public final class GithubRepository {
    public init() {}
}

extension GithubRepository: GithubRepositoryProtcol {
    public func fetchUser(userName: String) async throws -> UserModel {
        let request = GitHubAccountAPIRequest(userName: userName)
        return try await ApiClient.call(request)
    }
}
