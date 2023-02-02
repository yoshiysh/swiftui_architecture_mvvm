//
//  HomeUIState.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/28.
//

import Domain

struct HomeUIState {
    enum State {
        case initialzed, loading, suceess
        case error(_ error: NetworkErrorType)
    }

    var query: QueryDto
    private(set) var state: State = .initialzed
    private(set) var items: [RepositoryEntity] = []
    private(set) var totalCount: Int = -1

    var routeToSetting = false

    var isShowingAlert = false
    var alertMessage = ""

    init(query: QueryDto) {
        self.query = query
    }
}

extension HomeUIState {
    var isInitial: Bool {
        switch state {
        case .initialzed:
            return true
        case .loading:
            return isEmptyItem
        case .suceess, .error:
            return false
        }
    }

    var hasNextPage: Bool {
        items.count < totalCount
    }

    var isEmptyItem: Bool {
        items.isEmpty
    }

    func findIndex(item: RepositoryEntity) -> Int {
        items.firstIndex { $0.id == item.id } ?? -1
    }

    mutating func updateState(
        _ state: State,
        isShowAlertIfNeeded: Bool = true
    ) {
        self.state = state
        if case .error(let error) = state {
            alertMessage = error.errorMessage
            isShowingAlert = isShowAlertIfNeeded
        }
    }

    mutating func refresh() {
        items.removeAll()
        totalCount = -1
    }

    mutating func update(data: SearchResponseEntity) {
        data.items.forEach {
            if findIndex(item: $0) > 0 {
                return
            }
            items.append($0)
        }
        totalCount = data.totalCount
    }
}
