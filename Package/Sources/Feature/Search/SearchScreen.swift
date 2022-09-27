//
//  SearchScreen.swift
//  
//
//  Created by Yoshiki Hemmi on 2022/09/15.
//

import SwiftUI

public struct SearchScreen: View {
    
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

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreen()
    }
}
