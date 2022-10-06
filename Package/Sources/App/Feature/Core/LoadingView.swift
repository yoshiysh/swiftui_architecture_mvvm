//
//  LoadingView.swift
//
//
//  Created by yoshi on 2022/09/30.
//

import SwiftUI

public struct LoadingView: View {
    @State private var isAnimating = false

    public var body: some View {
        Circle()
            .trim(from: 0, to: 0.8)
            .stroke(AngularGradient(gradient: Gradient(colors: [.white, .gray]), center: .center),
                    style: StrokeStyle(lineWidth: 8, lineCap: .round, dash: [0.1, 12], dashPhase: 8)
            )
            .frame(width: 32, height: 32)
            .padding()
            .rotationEffect(.degrees(self.isAnimating ? 360 : 0))
            .onAppear {
                withAnimation(Animation.linear(duration: 1.2).repeatForever(autoreverses: false)) {
                    self.isAnimating = true
                }
            }
            .onDisappear {
                self.isAnimating = false
            }
    }

    public init() {}
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
            .previewLayout(.sizeThatFits)
    }
}
