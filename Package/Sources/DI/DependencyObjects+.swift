//
//  DependencyObjects+.swift
//
//
//  Created by Yoshiki Hemmi on 2022/09/27.
//

import Data
import Domain

public extension DependencyObjects {
    static let githubRepository = DependencyObject<GithubRepositoryProtcol> {
        GithubRepository()
    }
}
