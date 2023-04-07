//
//  GithubRepository.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/27.
//

import Combine

public protocol GithubRepository {
    func fetchUserAsync(userName: String) async throws -> UserEntity

    func searchRepositoryAsync(forQuery query: QueryDto) async throws -> SearchResponseEntity

    func searchRepositoryPublisher(forQuery query: QueryDto) -> AnyPublisher<SearchResponseEntity, NetworkErrorType>
}
