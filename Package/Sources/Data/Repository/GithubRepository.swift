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
    
    // MARK: api w/ async
    
    public func fetchUserAsync(userName: String) async throws -> UserEntity {
        let request = GitHubAccountAPIRequest(userName: userName)
        return try await ApiClient.call(request)
    }
    
    public func searchRepositoryAsync(forQuery query: QueryDto) async throws -> [RepositoryEntity] {
        let request = GitHubSearchAPIRequest(query: query)
        let response = try await ApiClient.publish(request).async()
        return response.items
    }
    
    // MARK: api w/ AnyPublisher
    
    public func searchRepositoryPublisher(forQuery query: QueryDto) -> AnyPublisher<[RepositoryEntity], NetworkErrorType> {
        let request = GitHubSearchAPIRequest(query: query)
        return ApiClient.publish(request).map { $0.items }
            .eraseToAnyPublisher()
    }
}
