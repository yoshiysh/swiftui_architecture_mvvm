//
//  RootScreen.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2023/02/08.
//

import SwiftUI

public struct TabLayout<Content: View>: View {
    @Namespace private var tablayout
    @State private var selection: TabLayoutType
    private let onTappedTab: (TabLayoutType) -> Void
    private let content: (TabLayoutType) -> Content

    public var body: some View {
        VStack {
            Spacer()

            Section(
                header:
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top) {
                            if !isSingleTab {
                                ForEach(0..<TabLayoutType.allCases.count, id: \.self) { index in
                                    let type = TabLayoutType.allCases[index]
                                    navBarButton(type: type) { type in
                                        onTappedTab(type)
                                    }
                                }
                            }
                        }
                        .frame(height: isSingleTab ? 0 : nil)
                        .frame(alignment: .top)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(0)
            ) {
                VStack {
                    Divider()

                    TabView(selection: $selection) {
                        ForEach(0..<TabLayoutType.allCases.count, id: \.self) { index in
                            let type = TabLayoutType.allCases[index]
                            content(type)
                                .tag(type)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .transition(.slide)
                    .animation(.easeInOut, value: selection)
                }
            }
        }
    }

    public init(
        selection: State<TabLayoutType>,
        onTappedTab: @escaping (TabLayoutType) -> Void,
        @ViewBuilder content: @escaping (TabLayoutType) -> Content
    ) {
        _selection = selection
        self.onTappedTab = onTappedTab
        self.content = content
    }
}

private extension TabLayout {
    private var count: Int {
        TabLayoutType.allCases.count
    }

    private var isSingleTab: Bool {
        count == 1
    }

    private var tabWidth: CGFloat {
        let screenWidth = UIScreen.main.bounds.size.width
        return max(120, screenWidth / CGFloat(count))
    }

    func navBarButton(
        type: TabLayoutType,
        action: @escaping (TabLayoutType) -> Void
    ) -> some View {
        Button {
            action(type)
        } label: {
            VStack {
                Text(type.text.uppercased())
                    .font(.footnote)
                    .foregroundColor(selection == type ? Color.blue : Color.gray)

                if selection == type {
                    Color.blue.frame(height: 2)
                        .matchedGeometryEffect(id: "underline", in: tablayout, properties: .frame)
                        .padding(.horizontal, 8)
                }
            }
            .animation(.spring(), value: selection)
        }
        .frame(width: tabWidth)
    }
}
