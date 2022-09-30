//
//  HomeViewState.swift
//
//
//  Created by Yoshiki Hemmi on 2022/09/28.
//

import Domain

public enum HomeViewState {
    case initialzed, loading, suceess
    case error(Error)
}
