//
//  Snackbar.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2023/02/01.
//

import SwiftUI

public struct Snackbar: View { // swiftlint:disable:this file_types_order
    public enum Length {
        case short, long

        var duration: UInt64 {
            switch self {
            case .short:
                return 2 * NSEC_PER_SEC
            case .long:
                return 3 * NSEC_PER_SEC
            }
        }
    }

    @Binding private var isPresented: Bool
    private let message: String
    private let foregroundColor: Color
    private let backgroundColor: Color
    private let length: Length
    @State private var opacity = 0.0
    private var icon: AnyView?

    private let targetView: AnyView

    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .center) {
                targetView

                if isPresented {
                    SnackContent(
                        proxy: proxy,
                        message: message,
                        foregroundColor: foregroundColor,
                        backgroundColor: backgroundColor,
                        opacity: opacity,
                        icon: icon
                    )
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .task {
                        opacity = 0.8
                        Task {
                            try await Task.sleep(nanoseconds: length.duration)
                            withAnimation {
                                isPresented = false
                                opacity = 0.0
                            }
                        }
                    }
                }
            }
        }
    }

    init<Content: View, Icon: View>(
        targetView: Content,
        isPresented: Binding<Bool>,
        message: String,
        foregroundColor: Color,
        backgroundColor: Color,
        length: Length,
        @ViewBuilder icon: @escaping () -> Icon?
    ) {
        self.targetView = AnyView(targetView)
        _isPresented = isPresented
        self.message = message
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.length = length
        if let icon = icon() {
            self.icon = AnyView(icon)
        }
    }
}

private struct SnackContent: View {
    let proxy: GeometryProxy
    let message: String
    let foregroundColor: Color
    let backgroundColor: Color
    let opacity: Double
    let icon: AnyView?

    var body: some View {
        HStack {
            Text(message)
            Spacer()
            if let icon = icon {
                icon
            }
        }
        .foregroundColor(foregroundColor)
        .padding()
        .frame(width: proxy.size.width * 0.92, height: 50)
        .shadow(radius: 4)
        .background(backgroundColor)
        .cornerRadius(8)
        .offset(x: 0, y: -10)
        .opacity(opacity)
        .animation(.easeInOut, value: opacity)
    }
}

extension View {
    public func snackbar<Icon: View>(
        isPresented: Binding<Bool>,
        message: String,
        foregroundColor: Color = .white,
        backgroundColor: Color = .red,
        length: Snackbar.Length = .short,
        @ViewBuilder icon: @escaping () -> Icon?
    ) -> some View {
        Snackbar(
            targetView: self,
            isPresented: isPresented,
            message: message,
            foregroundColor: foregroundColor,
            backgroundColor: backgroundColor,
            length: length,
            icon: icon
        )
    }

    public func snackbar(
        isPresented: Binding<Bool>,
        message: String,
        foregroundColor: Color = .white,
        backgroundColor: Color = .red,
        length: Snackbar.Length = .short
    ) -> some View {
        snackbar(
            isPresented: isPresented,
            message: message,
            foregroundColor: foregroundColor,
            backgroundColor: backgroundColor,
            length: length
        ) {}
    }
}
