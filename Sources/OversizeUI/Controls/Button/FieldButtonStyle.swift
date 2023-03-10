//
// Copyright © 2021 Alexander Romanov
// FieldButtonStyle.swift, created on 21.02.2023
//

import SwiftUI

public struct FieldButtonStyle: ButtonStyle {
    @Environment(\.theme) private var theme: ThemeSettings

    public init() {}

    public func makeBody(configuration: Self.Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.label
                .headline(.medium)
                .hLeading()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: Radius.medium, style: .continuous)
                .fill(configuration.isPressed ? Color.surfaceTertiary : Color.surfaceSecondary)
                .overlay(
                    RoundedRectangle(cornerRadius: Radius.medium,
                                     style: .continuous)
                        .stroke(theme.borderTextFields
                            ? Color.border
                            : Color.surfaceSecondary, lineWidth: CGFloat(theme.borderSize))
                )
        )
    }
}

public extension ButtonStyle where Self == FieldButtonStyle {
    static var field: FieldButtonStyle {
        FieldButtonStyle()
    }
}
