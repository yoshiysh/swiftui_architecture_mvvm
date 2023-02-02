//
//  SearchScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/15.
//

import SwiftUI

public struct SearchScreen: View {
    public var body: some View {
        searchView()
    }

    public init() {}
}

private extension View {
    func searchView() -> some View {
        Text("Hello, Search!")
    }
}

struct SearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreen()
    }
}
