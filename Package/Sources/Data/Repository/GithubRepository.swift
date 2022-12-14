//
//  GithubRepository.swift
//
//
//  Created by yoshi on 2022/09/27.
//

import Combine
import Domain

public final class GithubRepository {
    public init() {}
}

extension GithubRepository: GithubRepositoryProtcol {

    // MARK: api w/ async

    public func fetchUserAsync(userName: String) async throws -> UserEntity {
        let request = GitHubAccountAPIRequest(userName: userName)
        return try await ApiClient.call(request)
    }

    public func searchRepositoryAsync(forQuery query: QueryDto) async throws -> SearchResponseEntity {
        let request = GitHubSearchAPIRequest(query: query)
        return try await ApiClient.publish(request).async()
    }

    // MARK: api w/ AnyPublisher

    public func searchRepositoryPublisher(forQuery query: QueryDto) -> AnyPublisher<SearchResponseEntity, NetworkErrorType> {
        let request = GitHubSearchAPIRequest(query: query)
        return ApiClient.publish(request)
    }
}
