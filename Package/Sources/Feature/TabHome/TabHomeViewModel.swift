//
//  TabHomeViewModel.swift
//  swiftui_architecture_mvvm
//
//  Created by Yoshiki Hemmi on 2022/09/21.
//

import Foundation
import Combine
import DI
import Domain

@MainActor
public final class TabHomeViewModel: ObservableObject {
    
    @Inject(.githubRepository)
    private var repository: GithubRepositoryProtcol
    
    private var cancellables = Set<AnyCancellable>()
    
    public init() {
        Task {
            await getUserAsync()
        }
    }
    
    func getUserAsync() async {
        do {
            let user = try await repository.fetchUserAsync(userName: "yoshi991")
            debugPrint("user: \(user)")
        } catch {
            debugPrint("error: \(error)")
        }
    }
   
    func searchAsync() async {
        do {
            let repositories = try await repository.searchRepositoryAsync(keyword: "swift", language: nil, hasStars: nil, topic: nil)
            debugPrint("repositories: \(repositories)")
        } catch {
            debugPrint("error: \(error)")
        }
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
}
