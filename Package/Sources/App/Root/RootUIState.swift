//
//  RootUIState.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/14.
//

import UI_Core

struct RootUIState {
    enum State {
        case initialized, loggedOut, loggedIn
    }
    var state: State = .initialized
    var currentTab: TabType = .home
}
