//
//  HomeViewModel.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/28.
//

import Combine
import DI
import Domain
import UI_Core

@MainActor
final class HomeViewModel: ObservableObject {
    @Inject(.githubRepository)
    private var repository: GithubRepository

    @Published var uiState: HomeUIState
    private let defaultQuery: QueryDto

    init(language: String) {
        defaultQuery = QueryDto(language: language)
        uiState = .init(query: defaultQuery)
    }

    func fetch() async {
        await fetch(forQuery: defaultQuery)
    }

    func next() async {
        if !uiState.hasNextPage {
            return
        }
        uiState.query.page += 1
        await fetch(forQuery: uiState.query, isForce: true)
    }

    func refresh() async {
        uiState.query.page = 1
        await fetch(forQuery: uiState.query, isForce: true, isRefresh: true)
    }

    func showSnackbar() {
        uiState.updateState(.error(NetworkErrorType.unknown))
    }

    private func fetch(
        forQuery query: QueryDto,
        isForce force: Bool = false,
        isRefresh: Bool = false
    ) async {
        switch uiState.state {
        case .loading:
            return
        case .suceess:
            if !force && !uiState.isEmptyItem {
                return
            }
        case .initialzed, .error:
            break
        }
        uiState.updateState(.loading)

        await search(query: query, isRefresh: isRefresh)
    }

    private func search(
        query: QueryDto,
        isRefresh: Bool
    ) async {
        do {
            let response = try await repository.searchRepositoryAsync(forQuery: query)
            handleSuccessResponse(response: response, isRefresh: isRefresh)
        } catch {
            debugPrint("error: \(error)")
            if let error = error as? NetworkErrorType {
                uiState.updateState(.error(error))
            } else {
                uiState.updateState(.error(NetworkErrorType.unknown))
            }
        }
    }

    private func handleSuccessResponse(
        response: SearchResponseEntity,
        isRefresh: Bool = false
    ) {
        if isRefresh { uiState.refresh() }
        uiState.update(data: response)
        uiState.updateState(.suceess)
    }
}
