//
//  GithubRepository.swift
//  
//
//  Created by Yoshiki Hemmi on 2022/09/27.
//

import Combine
import Domain

public final class GithubRepository {
    public init() {}
}

extension GithubRepository: GithubRepositoryProtcol {
    public func fetchUserAsync(userName: String) async throws -> UserEntity {
        let request = GitHubAccountAPIRequest(userName: userName)
        return try await ApiClient.call(request)
    }
    
    public func searchRepositoryAsync(
        keyword: String?,
        language: String?,
        hasStars: Int?,
        topic: String?
    ) async throws -> SearchResponseEntity {
        let request = GitHubSearchAPIRequest(keyword: keyword, language: language, hasStars: hasStars, topic: topic)
        return try await ApiClient.publish(request).async()
    }
}
