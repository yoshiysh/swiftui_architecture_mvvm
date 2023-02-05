//
//  Sidebar.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2023/02/05.
//

import SwiftUI

/// ref.) https://blog.logrocket.com/create-custom-collapsible-sidebar-swiftui/
public struct Sidebar: View {

    @Binding private var isPresented: Bool
    private let targetView: AnyView
    private let foregroundColor: Color
    private let backgroundColor: Color
    private var content: AnyView

    private let sideBarWidth = UIScreen.main.bounds.size.width * 0.7
    private let chevronYpos = UIScreen.main.bounds.size.height * 0.8

    public var body: some View {
        ZStack {
            targetView

            ZStack {
                GeometryReader { _ in
                    EmptyView()
                }
                .background(.black.opacity(0.6))
                .opacity(isPresented ? 1 : 0)
                .animation(.easeInOut.delay(0.2), value: isPresented)
                .onTapGesture {
                    isPresented.toggle()
                }
                container()
            }
            .edgesIgnoringSafeArea(.all)
        }
    }

    init<Body: View, Content: View>(
        targetView: Body,
        isPresented: Binding<Bool>,
        foregroundColor: Color,
        backgroundColor: Color,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.targetView = AnyView(targetView)
        _isPresented = isPresented
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.content = AnyView(content())
    }
}

private extension Sidebar {
    func container() -> some View {
        HStack(alignment: .top) {
            ZStack(alignment: .top) {
                backgroundColor
                menuChevron()

                content
            }
            .frame(width: sideBarWidth)
            .offset(x: isPresented ? 0 : -sideBarWidth)
            .animation(.default, value: isPresented)

            Spacer()
        }
    }

    func menuChevron() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18)
                .fill(backgroundColor)
                .frame(width: 60, height: 60)
                .rotationEffect(Angle(degrees: 45))
                .offset(x: isPresented ? -18 : -10)
                .onTapGesture {
                    isPresented.toggle()
                }

            Image(systemName: "chevron.right")
                .foregroundColor(foregroundColor)
                .rotationEffect(isPresented ? Angle(degrees: 180) : Angle(degrees: 0))
                .offset(x: isPresented ? -4 : 8)
                .foregroundColor(.blue)
        }
        .offset(x: sideBarWidth / 2, y: chevronYpos)
        .animation(.default, value: isPresented)
    }
}

public extension View {
    func sidebar<Content: View>(
        isPresented: Binding<Bool>,
        foregroundColor: Color = .white,
        backgroundColor: Color = .cyan,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        Sidebar(
            targetView: self,
            isPresented: isPresented,
            foregroundColor: foregroundColor,
            backgroundColor: backgroundColor,
            content: content
        )
    }
}
