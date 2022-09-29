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
    private var cancellables = Set<AnyCancellable>()
    private var query = QueryDto(language: "swift")
    
    public init() {}
    
    func fetch() async {
        switch state {
        case .loading:
            return
        case .suceess(let items):
            if !items.isEmpty { return }
        default:
            break
        }
        state = .loading
        
        await search(query: query)
    }
    
    private func search(query: QueryDto) async {
        do {
            let result = try await repository.searchRepositoryAsync(forQuery: query)
            handleSuccessResponse(result: result)
        } catch {
            debugPrint("error: \(error)")
            state = .error(NetworkErrorType.irregularError(info: error.localizedDescription.description))
        }
    }
    
    private func handleSuccessResponse(
        result: [RepositoryEntity],
        isRefresh: Bool = false
    ) {
        var items: [RepositoryEntity]
        switch state {
        case .suceess(let data):
            if isRefresh { items = [] }
            else { items = data }
        default:
            items = []
        }
        
        result.forEach { items.append($0) }
        state = .suceess(items)
    }
}
