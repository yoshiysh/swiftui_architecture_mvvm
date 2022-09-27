//
//  Injection.swift
//  
//
//  Created by Yoshiki Hemmi on 2022/09/27.
//

import Domain
import Infrastructure

public extension DependencyObjects {
    static let githubRepository = DependencyObject<GithubRepositoryProtcol> {
        GithubRepository()
    }
}
