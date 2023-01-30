//
//  HomeViewState.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/28.
//

import Domain

enum HomeViewState {
    case initialzed, loading, suceess
    case error(Error)
}
