//
//  Snackbar.swift
//  swiftui_architecture_mvvm
//
//  Created by yoshi on 2023/02/01.
//

import SwiftUI

public struct Snackbar: View {
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
    @State private var opacity = 0.0
    private let targetView: AnyView
    private let message: String
    private let foregroundColor: Color
    private let backgroundColor: Color
    private let length: Length
    private var icon: AnyView
    private let onDismiss: () -> Void

    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .center) {
                targetView

                if isPresented {
                    snackContent(
                        proxy: proxy,
                        message: message,
                        foregroundColor: foregroundColor,
                        backgroundColor: backgroundColor,
                        opacity: opacity,
                        icon: icon
                    )
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .onAnimationCompleted(for: opacity) {
                        isPresented = false
                        onDismiss()
                    }
                    .task {
                        opacity = 0.8
                        try? await Task.sleep(nanoseconds: length.duration)
                        withAnimation(.easeInOut) { opacity = 0.0 }
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
        @ViewBuilder icon: @escaping () -> Icon,
        onDismiss: @escaping () -> Void
    ) {
        self.targetView = AnyView(targetView)
        _isPresented = isPresented
        self.message = message
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
        self.length = length
        self.icon = AnyView(icon())
        self.onDismiss = onDismiss
    }
}

private extension View {
    func snackContent( // swiftlint:disable:this function_parameter_count
        proxy: GeometryProxy,
        message: String,
        foregroundColor: Color,
        backgroundColor: Color,
        opacity: Double,
        icon: AnyView?
    ) -> some View {
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
    }
}

public extension View {
    func snackbar<Icon: View>(
        isPresented: Binding<Bool>,
        message: String,
        foregroundColor: Color = .white,
        backgroundColor: Color = .red,
        length: Snackbar.Length = .short,
        @ViewBuilder icon: @escaping () -> Icon,
        onDismiss: @escaping () -> Void = {}
    ) -> some View {
        Snackbar(
            targetView: self,
            isPresented: isPresented,
            message: message,
            foregroundColor: foregroundColor,
            backgroundColor: backgroundColor,
            length: length,
            icon: icon,
            onDismiss: onDismiss
        )
    }

    func snackbar(
        isPresented: Binding<Bool>,
        message: String,
        foregroundColor: Color = .white,
        backgroundColor: Color = .red,
        length: Snackbar.Length = .short,
        onDismiss: @escaping () -> Void = {}
    ) -> some View {
        snackbar(
            isPresented: isPresented,
            message: message,
            foregroundColor: foregroundColor,
            backgroundColor: backgroundColor,
            length: length
        ) {
        } onDismiss: {
            onDismiss()
        }
    }
}
