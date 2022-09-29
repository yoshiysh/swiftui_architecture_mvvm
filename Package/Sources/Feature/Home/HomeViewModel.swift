//
//  HomeViewModel.swift
//  swiftui_architecture_mvvm
//
//  Created by Yoshiki Hemmi on 2022/09/28.
//

import Foundation
import Combine
import DI
import Domain

@MainActor
public final class HomeViewModel: ObservableObject {
    
    @Inject(.githubRepository)
    private var repository: GithubRepositoryProtcol
    
    @Published private(set) var state: HomeViewState = .initialzed
    @Published var data: HomeDataModel = .init()
    
    private var cancellables = Set<AnyCancellable>()
    private var defaultQuery = QueryDto(language: "swift")
    private let offset = 1
    
    public init() {}
    
    func fetch() async {
        await fetch(forQuery: defaultQuery)
    }
    
    func next() async {
        data.query.page += 1
        await fetch(forQuery: data.query, isForce: true)
    }
    
    private func fetch(
        forQuery query: QueryDto,
        isForce force: Bool = false
    ) async {
        switch state {
        case .loading:
            return
        case .suceess:
            if !force && !data.isEmpty { return }
        case .initialzed, .error(_):
            break
        }
        state = .loading
        
        await search(query: query)
    }
    
    private func search(query: QueryDto) async {
        do {
            let response = try await repository.searchRepositoryAsync(forQuery: query)
            handleSuccessResponse(response: response)
        } catch {
            debugPrint("error: \(error)")
            state = .error(NetworkErrorType.irregularError(info: error.localizedDescription.description))
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
