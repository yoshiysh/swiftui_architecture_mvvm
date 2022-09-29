//
//  RepositoryCardView.swift
//  
//
//  Created by Yoshiki Hemmi on 2022/09/29.
//

import SwiftUI
import Domain

public struct RepositoryCardView: View {
    
    @Binding var item: RepositoryModel
    
    public var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct RepositoryCardView_Previews: PreviewProvider {
    private struct Preview: View {
        @State private var model = RepositoryModel.preview
        
        var body: some View {
            RepositoryCardView(item: $model)
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
