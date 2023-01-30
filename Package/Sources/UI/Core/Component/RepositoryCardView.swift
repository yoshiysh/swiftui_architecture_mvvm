//
//  RepositoryCardView.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2022/09/29.
//

import Domain
import SwiftUI

public struct RepositoryCardView: View { // swiftlint:disable:this file_types_order
    let item: RepositoryEntity

    public var body: some View {
        RepositoryCardContentView(item: item)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.gray, lineWidth: 1)
            )
    }

    public init(item: RepositoryEntity) {
        self.item = item
    }
}

private struct RepositoryCardContentView: View {
    let item: RepositoryEntity

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            AsyncImage(url: item.owner.avatarUrl) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .frame(width: 48, height: 48)
            .clipShape(Circle())
            .shadow(color: .gray, radius: 4, x: 0, y: 0)

            RepositoryInfoView(item: item)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

private struct RepositoryInfoView: View {
    let item: RepositoryEntity

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(item.owner.login)
                .font(.title3)
                .fontWeight(.bold)

            Text(item.name)
                .font(.headline)

            if let description = item.description {
                Text(description)
                    .foregroundColor(.gray)
                    .font(.subheadline)
                    .lineLimit(3)
            }

            Text("Updated At: \(DateUtil.shared.formatDate(from: item.updatedAt, format: .YYYYMMDD))")
                .font(.caption)
                .foregroundColor(.gray)
                .font(.subheadline)
                .lineLimit(1)

            RepositoryTagsView(item: item)
        }
    }
}

private struct RepositoryTagsView: View {
    let item: RepositoryEntity
    private let raduis: CGFloat = 16

    var body: some View {
        HStack {
            if let language = item.language {
                Text(language)
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .lineLimit(1)
                    .padding(8)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: raduis))
            }

            Label(title: {
                Text("\(item.stargazersCount)")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .lineLimit(1)
            }, icon: {
                Image(systemName: "star")
                    .foregroundColor(.white)
            })
            .padding(8)
            .background(.yellow)
            .clipShape(RoundedRectangle(cornerRadius: raduis))
        }
    }
}

struct RepositoryCardView_Previews: PreviewProvider {
    private struct Preview: View {
        var body: some View {
            RepositoryCardView(item: RepositoryEntity.preview)
        }
    }

    static var previews: some View {
        Preview()
            .previewLayout(.sizeThatFits)
    }
}
