//
//  WebViewError.swift
//
//
//  Created by Yoshiki Hemmi on 2022/10/02.
//

import Foundation

public struct WebViewError: Equatable {
    let code: URLError.Code
    let message: String
}
