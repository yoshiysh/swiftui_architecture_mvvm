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
    static let authRepository = DependencyObject<AuthRepository> {
        AuthDefaultRepository()
    }

    static let githubRepository = DependencyObject<GithubRepository> {
        GithubDefaultRepository()
    }
}

// MARK: UseCase

public extension DependencyObjects {
    static let authUseCase = DependencyObject<AuthUseCase> {
        AuthDefaultUseCase(repository: authRepository.object)
    }
}
