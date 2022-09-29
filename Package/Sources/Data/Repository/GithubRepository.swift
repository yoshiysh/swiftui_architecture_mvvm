//
//  GithubRepository.swift
//  
//
//  Created by Yoshiki Hemmi on 2022/09/27.
//

import Combine
import Domain

public final class GithubRepository {
    private let perPage: Int = 10
    
    public init() {}
}

extension GithubRepository: GithubRepositoryProtcol {
    
    // MARK: api w/ async
    
    public func fetchUserAsync(userName: String) async throws -> UserEntity {
        let request = GitHubAccountAPIRequest(userName: userName)
        return try await ApiClient.call(request)
    }
    
    public func searchRepositoryAsync(
        keyword: String?,
        language: String?,
        hasStars: Int?,
        topic: String?,
        page: Int?
    ) async throws -> [RepositoryEntity] {
        let request = GitHubSearchAPIRequest(
            keyword: keyword,
            language: language,
            hasStars: hasStars,
            topic: topic,
            perPage: perPage,
            page: page
        )
        let response = try await ApiClient.publish(request).async()
        return response.items
    }
    
    // MARK: api w/ AnyPublisher
    
    public func searchRepositoryPublisher(
        keyword: String?,
        language: String?,
        hasStars: Int?,
        topic: String?,
        page: Int?
    ) -> AnyPublisher<[RepositoryEntity], NetworkErrorType> {
        let request = GitHubSearchAPIRequest(
            keyword: keyword,
            language: language,
            hasStars: hasStars,
            topic: topic,
            perPage: perPage,
            page: page
        )
        return ApiClient.publish(request).map { $0.items }
            .eraseToAnyPublisher()
    }
}
