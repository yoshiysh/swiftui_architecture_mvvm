//
//  LiquidMenuButtons.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2023/02/07.
//

import SwiftUI

public struct LiquidMenuButtons: View {
    @State private var offsets: [MenuIcon: CGSize] = [:]
    @State private var isCollapsed = false

    private let forgroundColor: Color
    private let backgroundColor: Color
    private let action: (MenuIcon) -> Void

    public var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.black.opacity(isCollapsed ? 0.6 : 0)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .animation(.easeInOut.delay(0.2), value: isCollapsed)
                    .onTapGesture {
                        withAnimation {
                            isCollapsed.toggle()
                        }
                        withAnimation(
                            .interactiveSpring(response: 0.35, dampingFraction: 0.8, blendDuration: 0.1)
                                .speed(0.5)
                        ) {
                            updateOffsets()
                        }
                    }
                    .edgesIgnoringSafeArea(.all)

                container(
                    proxy: proxy,
                    backgroundColor: backgroundColor
                )
            }
        }
    }

    public init(
        forgroundColor: Color = .white,
        backgroundColor: Color = .blue,
        action: @escaping (MenuIcon) -> Void
    ) {
        self.forgroundColor = forgroundColor
        self.backgroundColor = backgroundColor
        self.action = action

        MenuIcon.allCases.forEach { symbol in
            offsets[symbol] = .zero
        }
    }
}

private extension LiquidMenuButtons {
    var maxDiameter: CGFloat {
        var size: CGFloat = 0
        if let icon = MenuIcon.allCases.first {
            size = MenuIcon.allCases.reduce(icon.diameter) { max($0, $1.diameter) }
        }
        return size
    }

    func container(
        proxy: GeometryProxy,
        backgroundColor: Color
    ) -> some View {
        ZStack {
            gradientSymbols()
                .allowsHitTesting(false)

            symbolButton(icon: .menu)
                .blendMode(.hardLight)
                .rotationEffect(Angle(degrees: isCollapsed ? 90 : 45))

            symbolButtons()
        }
        .offset(defaultButtonPosition(proxy: proxy))
    }

    func gradientSymbols() -> some View {
        Rectangle()
            .fill(
                .linearGradient(colors: [.blue, .purple], startPoint: .bottom, endPoint: .top)
            )
            .mask {
                Canvas { context, size in
                    context.addFilter(.alphaThreshold(min: 0.8, color: .black))
                    context.addFilter(.blur(radius: 8))

                    context.drawLayer { ctx in
                        for index in 0..<MenuIcon.allCases.count {
                            if let resolvedView = context.resolveSymbol(id: index) {
                                ctx.draw(resolvedView, at: CGPoint(x: size.width / 2, y: size.height / 2))
                            }
                        }
                    }
                } symbols: {
                    ForEach(0..<MenuIcon.allCases.count, id: \.self) { index in
                        let icon = MenuIcon.allCases[index]
                        symbol(icon: icon, offset: offsets[icon] ?? .zero)
                            .tag(index)
                    }
                }
            }
    }

    func symbol(icon: MenuIcon, offset: CGSize = .zero) -> some View {
        Circle()
            .frame(width: icon.diameter, height: icon.diameter)
            .offset(offset)
    }

    func symbolButtons() -> some View {
        ForEach(1..<MenuIcon.allCases.count, id: \.self) { index in
            let icon = MenuIcon.allCases[index]
            symbolButton(icon: icon)
                .offset(offsets[icon] ?? .zero)
                .blendMode(.hardLight)
                .opacity(isCollapsed ? 1 : 0)
        }
    }

    func symbolButton(icon: MenuIcon) -> some View {
        Image(systemName: icon.imageName)
            .resizable()
            .foregroundColor(forgroundColor)
            .frame(width: icon.iconSize, height: icon.iconSize)
            .contentShape(Rectangle())
            .onTapGesture {
                action(icon)
                withAnimation {
                    isCollapsed.toggle()
                }
                withAnimation(
                    .interactiveSpring(response: 0.35, dampingFraction: 0.8, blendDuration: 0.1)
                        .speed(0.5)
                ) {
                    updateOffsets()
                }
            }
    }

    func updateOffsets() {
        for index in 1..<MenuIcon.allCases.count {
            let icon = MenuIcon.allCases[index]
            offsets[icon] = isCollapsed ? CGSize(width: 0, height: calcOffset(icon: icon)) : .zero
        }
    }

    func calcOffset(icon: MenuIcon) -> Int {
        guard let current: Int = MenuIcon.allCases.firstIndex(of: icon), current != 0 else {
            return 0
        }

        let defaultPosition = Int(maxDiameter) + 8
        var height: Int = 0
        for index in 1..<current {
            let ic = MenuIcon.allCases[index]
            if index == current {
                height += Int(ic.diameter) / 2
            } else {
                height += Int(ic.diameter * 1.1)
            }
        }
        return -(defaultPosition + height)
    }

    func defaultButtonPosition(proxy: GeometryProxy) -> CGSize {
        let x = (proxy.size.width - maxDiameter) / 2 - 8
        let y = proxy.size.height / 2 - 48
        return CGSize(width: x, height: y)
    }
}
