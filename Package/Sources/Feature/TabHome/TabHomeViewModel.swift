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
    
    public init() {}
    
    func getUser() async {
        do {
            let user = try await repository.fetchUser(userName: "yoshi991")
            debugPrint("user: \(user)")
        } catch {
            debugPrint("error: \(error)")
        }
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
}
