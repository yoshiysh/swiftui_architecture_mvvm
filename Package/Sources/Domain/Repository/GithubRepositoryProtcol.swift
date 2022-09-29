//
//  GithubRepositoryProtcol.swift
//  
//
//  Created by Yoshiki Hemmi on 2022/09/27.
//

import Combine

public protocol GithubRepositoryProtcol {
    func fetchUserAsync(userName: String) async throws -> UserModel
    
    func searchRepositoryAsync(
        keyword: String?,
        language: String?,
        hasStars: Int?,
        topic: String?
    ) async throws -> [RepositoryModel]
    
    func searchRepositoryPublisher(
        keyword: String?,
        language: String?,
        hasStars: Int?,
        topic: String?
    ) -> AnyPublisher<[RepositoryModel], NetworkErrorType>
}
