//
//  BaseAPIProtocol.swift
//  
//
//  Created by Yoshiki Hemmi on 2022/09/27.
//

import Foundation

protocol BaseAPIProtocol {
    associatedtype ResponseType: Codable

    var method: HTTPMethod { get }
    var baseUrl: URL { get }
    var path: String { get }
    var headers: [String : String] { get }
}

extension BaseAPIProtocol {
    var baseUrl: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var headers: [String : String] {
        return [
            "Content-Type": "application/json; charset=utf-8"
        ]
    }
}
