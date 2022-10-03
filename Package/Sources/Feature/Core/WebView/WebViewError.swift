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
        if let error = error as? WebViewError {
            return error
        }

        if let error = error as? URLError {
            return WebViewError(code: error.code, message: error.localizedDescription)
        }

        return WebViewError(code: URLError.badURL, message: "Bad URL.")
    }
}
