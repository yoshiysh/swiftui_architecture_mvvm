//
//  BaseAPIProtocol.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/27.
//

import Foundation

public protocol BaseAPIProtocol {
    associatedtype ResponseType: Decodable

    var method: HTTPMethod { get }
    var baseUrl: URL { get }
    var path: String { get }
    var headers: [String: String] { get }
}

public extension BaseAPIProtocol {
    var baseUrl: URL {
        if let url = URL(string: "https://api.github.com") {
            return url
        } else {
            fatalError("Invalid URL.")
        }
    }

    var headers: [String: String] {
        [
            "Content-Type": "application/json; charset=utf-8"
        ]
    }
}
