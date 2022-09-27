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
//        Task {
//            await getUserAsync()
//        }
        
        searchPublisher()
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
    
    func searchPublisher() {
        repository.searchRepositoryPublisher(keyword: "swift", language: nil, hasStars: nil, topic: nil)
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    debugPrint("result: \(result)")
                case .failure(let error):
                    debugPrint("error: \(error)")
                }
            }, receiveValue: { value in
                debugPrint("result: \(value)")
            })
            .store(in: &cancellables)
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
}
