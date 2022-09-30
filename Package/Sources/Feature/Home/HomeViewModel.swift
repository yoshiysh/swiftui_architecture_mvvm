//
//  HomeViewModel.swift
//  swiftui_architecture_mvvm
//
//  Created by Yoshiki Hemmi on 2022/09/28.
//

import Combine
import DI
import Domain
import Foundation

@MainActor
public final class HomeViewModel: ObservableObject {

    @Inject(.githubRepository)
    private var repository: GithubRepositoryProtcol

    @Published private(set) var state: HomeViewState = .initialzed
    @Published var data: HomeDataModel

    private var cancellables = Set<AnyCancellable>()
    private var defaultQuery = QueryDto(language: "swift")

    public init() {
        self.data = .init(query: defaultQuery)
    }

    func fetch() async {
        await fetch(forQuery: defaultQuery)
    }

    func next() async {
        if !data.hasNextPage {
            return
        }
        data.query.page += 1
        await fetch(forQuery: data.query, isForce: true)
    }

    func refresh() async {
        data.query.page = 1
        await fetch(forQuery: data.query, isForce: true, isRefresh: true)
    }

    private func fetch(
        forQuery query: QueryDto,
        isForce force: Bool = false,
        isRefresh: Bool = false
    ) async {
        switch state {
        case .loading:
            return
        case .suceess:
            if !force && !data.isEmpty {
                return
            }
        case .initialzed, .error:
            break
        }
        state = .loading

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
            state = .error(error)
        }
    }

    private func handleSuccessResponse(
        response: SearchResponseEntity,
        isRefresh: Bool = false
    ) {
        if isRefresh { data.refresh() }
        data.update(data: response)
        state = .suceess
    }
}
