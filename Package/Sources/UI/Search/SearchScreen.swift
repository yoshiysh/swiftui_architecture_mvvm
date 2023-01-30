//
//  SearchScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/15.
//

import SwiftUI

public struct SearchScreen: View { // swiftlint:disable:this file_types_order
    public var body: some View {
        SearchView()
    }

    public init() {}
}

private struct SearchView: View {
    var body: some View {
        Text("Hello, Search!")
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreen()
    }
}
