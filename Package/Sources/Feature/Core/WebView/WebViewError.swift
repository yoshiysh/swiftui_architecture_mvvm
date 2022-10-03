//
//  WebViewError.swift
//
//
//  Created by Yoshiki Hemmi on 2022/10/02.
//

import Foundation

struct WebViewError: Error {
    let code: URLError.Code
    let message: String
}

extension WebViewError {
    static func handleError(_ error: Error? = nil) -> WebViewError {
        switch error {
        case let err as WebViewError:
            return err
        case let err as URLError:
            return WebViewError(code: err.code, message: err.localizedDescription)
        default:
            return WebViewError(code: URLError.badURL, message: "Bad URL.")
        }
    }
}
