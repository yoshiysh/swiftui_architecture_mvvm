//
//  DependencyObjects+.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/27.
//

import Data_Repository
import Domain

// MARK: Repository

public extension DependencyObjects {
    static let authRepository = DependencyObject<any AuthRepository> {
        AuthDefaultRepository()
    }

    static let githubRepository = DependencyObject<any GithubRepository> {
        GithubDefaultRepository()
    }
}

// MARK: UseCase

public extension DependencyObjects {
    static let authUseCase = DependencyObject<any AuthUseCase> {
        AuthDefaultUseCase(repository: authRepository.object)
    }
}
