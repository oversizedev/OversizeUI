//
// Copyright © 2022 Alexander Romanov
// Bage.swift
//

import SwiftUI

public struct Bage<Label: View>: View {
    @Environment(\.theme) private var theme: ThemeSettings

    private let label: Label
    private var color: Color
    private var radius: Radius

    public init(color: Color = .accentColor, radius: Radius = .small, @ViewBuilder label: () -> Label) {
        self.color = color
        self.radius = radius
        self.label = label()
    }

    public var body: some View {
        HStack {
            label
                .foregroundColor(color)
                .fontStyle(.caption)
        }
        .padding(.vertical, .xxxSmall)
        .padding(.horizontal, 6)
        .background(
            RoundedRectangle(cornerRadius: radius.rawValue,
                             style: .circular)
                .fill(color.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: radius.rawValue,
                                     style: .continuous)
                        .stroke(
                            theme.borderSurface
                                ? Color.border
                                : Color.clear
                        )
                )
        )
    }
}
