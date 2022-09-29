//
//  GithubRepositoryProtcol.swift
//  
//
//  Created by Yoshiki Hemmi on 2022/09/27.
//

import Combine

public protocol GithubRepositoryProtcol {
    func fetchUserAsync(userName: String) async throws -> UserEntity
    
    func searchRepositoryAsync(forQuery query: QueryDto) async throws -> [RepositoryEntity]
    
    func searchRepositoryPublisher(forQuery query: QueryDto) -> AnyPublisher<[RepositoryEntity], NetworkErrorType>
}
