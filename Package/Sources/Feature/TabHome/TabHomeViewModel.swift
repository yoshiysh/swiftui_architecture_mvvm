//
//  TabHomeViewModel.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/21.
//

import Combine
import DI
import Domain
import Foundation

@MainActor
final class TabHomeViewModel: ObservableObject {

    @Inject(.githubRepository)
    private var repository: GithubRepositoryProtcol

    private var cancellables = Set<AnyCancellable>()
    private var query = QueryDto(keyword: "ios", language: "swift")

    /// Usage:
    /// Task { await getUserAsync() }
    func getUserAsync() async {
        do {
            let user = try await repository.fetchUserAsync(userName: "yoshi991")
            debugPrint("user: \(user)")
        } catch {
            debugPrint("error: \(error)")
        }
    }

    /// Usage:
    /// Task { await searchAsync() }
    func searchAsync() async {
        do {
            let repositories = try await repository.searchRepositoryAsync(forQuery: query)
            debugPrint("repositories: \(repositories)")
        } catch {
            debugPrint("error: \(error)")
        }
    }

    /// Usage:
    /// searchPublisher()
    func searchPublisher() {
        repository.searchRepositoryPublisher(forQuery: query)
            .sink(success: { result in
                debugPrint("result: \(result)")
            }, failure: { error in
                debugPrint("error: \(error)")
            }, completion: {
                debugPrint("completion")
            })
            .store(in: &cancellables)
    }
}
