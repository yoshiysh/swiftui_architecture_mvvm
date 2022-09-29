//
//  HomeViewState.swift
//  
//
//  Created by Yoshiki Hemmi on 2022/09/28.
//

import Domain

public enum HomeViewState: Equatable {
    case initialzed, loading
    case suceess([RepositoryModel])
    case error(NetworkErrorType)
}
