//
// Copyright © 2026 Alexander Romanov
// DottedBorder.swift, created on 05.09.2026
//

import SwiftUI

public struct DottedBorderModifier: ViewModifier {
    @Environment(\.theme) private var theme

    private let cornerRadius: CGFloat
    private let lineWidth: CGFloat?
    private let dash: [CGFloat]
    private let color: Color

    public init(
        cornerRadius: CGFloat = .medium,
        lineWidth: CGFloat? = nil,
        dash: [CGFloat] = [4, 4],
        color: Color = .border
    ) {
        self.cornerRadius = cornerRadius
        self.lineWidth = lineWidth
        self.dash = dash
        self.color = color
    }

    public func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(
                    cornerRadius: cornerRadius,
                    style: .continuous
                )
                .strokeBorder(
                    color,
                    style: StrokeStyle(
                        lineWidth: lineWidth ?? theme.borderSize,
                        dash: dash
                    )
                )
                .allowsHitTesting(false)
            )
    }
}

public extension View {
    func dottedBorder(
        cornerRadius: CGFloat = .medium,
        lineWidth: CGFloat? = nil,
        dash: [CGFloat] = [4, 4],
        color: Color = .border
    ) -> some View {
        modifier(DottedBorderModifier(
            cornerRadius: cornerRadius,
            lineWidth: lineWidth,
            dash: dash,
            color: color
        ))
    }
}

#Preview {
    VStack(spacing: .medium) {
        Text("Default")
            .padding(.medium)
            .frame(maxWidth: .infinity)
            .dottedBorder()

        Text("Custom")
            .padding(.medium)
            .frame(maxWidth: .infinity)
            .dottedBorder(cornerRadius: .large, lineWidth: 2, dash: [8, 4], color: .accent)
    }
    .padding(.medium)
    .background(Color.backgroundSecondary)
}
