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
        
        await searchRepositories(keyword: "swift")
    }
    
    private func searchRepositories(
        keyword: String? = nil,
        language: String? = nil,
        hasStars: Int? = nil,
        topic: String? = nil
    ) async {
        do {
            let result = try await repository.searchRepositoryAsync(
                keyword: keyword,
                language: language,
                hasStars: hasStars,
                topic: topic,
                page: 1
            )
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
