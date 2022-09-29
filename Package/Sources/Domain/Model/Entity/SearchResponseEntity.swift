//
//  SearchResponseEntity.swift
//  
//
//  Created by Yoshiki Hemmi on 2022/09/27.
//

import Foundation

public struct SearchResponseEntity: Codable {
    public let items: [RepositoryEntity]
    
    public func convertItem() -> [RepositoryModel] {
        items.map { $0.convertItem() }
    }
}
