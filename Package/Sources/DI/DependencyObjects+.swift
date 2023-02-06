//
//  DependencyObjects+.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/27.
//

import Data_Repository
import Domain

public extension DependencyObjects {
    static let authRepository = DependencyObject<AuthRepositoryProtocol> {
        AuthDefaultRepository()
    }

    static let githubRepository = DependencyObject<GithubRepositoryProtcol> {
        GithubDefaultRepository()
    }
}
