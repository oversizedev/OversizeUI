//
// Copyright © 2021 Alexander Romanov
// Badge.swift, created on 20.02.2022
//

import SwiftUI

public struct Badge<Label: View>: View {
    @Environment(\.theme) private var theme: ThemeSettings
    @Environment(\.controlRadius) private var controlRadius

    private let label: Label
    private let color: Color

    public init(color: Color = .accentColor, @ViewBuilder label: () -> Label) {
        self.color = color
        self.label = label()
    }

    public var body: some View {
        HStack {
            label
                .foregroundColor(color)
                .caption(.medium)
        }
        .padding(.vertical, .xxxSmall)
        .padding(.horizontal, .xxSmall)
        .background(
            RoundedRectangle(
                cornerRadius: controlRadius,
                style: .continuous
            )
            .fill(color.opacity(0.1))
            .overlay(
                RoundedRectangle(
                    cornerRadius: controlRadius,
                    style: .continuous
                )
                .stroke(
                    theme.borderSurface
                        ? Color.border
                        : Color.clear
                )
            )
        )
    }
}

// MARK: - Previews

#Preview {
    VStack(spacing: .small) {
        Badge {
            Text("Default")
        }

        Badge(color: .success) {
            Text("Success")
        }

        Badge(color: .error) {
            Text("Error")
        }

        Badge(color: .warning) {
            HStack(spacing: .xxxSmall) {
                Icon(Image.Base.info)
                    .iconSize(.xSmall)

                Text("With icon")
            }
        }
    }
    .padding()
}
