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
    
    public func fetchUserAsync(userName: String) async throws -> UserModel {
        let request = GitHubAccountAPIRequest(userName: userName)
        let response = try await ApiClient.call(request)
        return response.convertItem()
    }
    
    public func searchRepositoryAsync(
        keyword: String?,
        language: String?,
        hasStars: Int?,
        topic: String?
    ) async throws -> [RepositoryModel] {
        let request = GitHubSearchAPIRequest(keyword: keyword, language: language, hasStars: hasStars, topic: topic)
        let response = try await ApiClient.publish(request).async()
        return response.convertItem()
    }
    
    // MARK: api w/ AnyPublisher
    
    public func searchRepositoryPublisher(
        keyword: String?,
        language: String?,
        hasStars: Int?,
        topic: String?
    ) -> AnyPublisher<[RepositoryModel], NetworkErrorType> {
        let request = GitHubSearchAPIRequest(keyword: keyword, language: language, hasStars: hasStars, topic: topic)
        return ApiClient.publish(request).map {
            $0.convertItem()
        }
        .eraseToAnyPublisher()
    }
}
