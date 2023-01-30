//
//  ContentsEmptyView.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/30.
//

import SwiftUI

public struct ContentsEmptyView: View {
    public var body: some View {
        Text("Contents is Empty")
    }

    public init() {}
}

struct ContentsEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        ContentsEmptyView()
    }
}
