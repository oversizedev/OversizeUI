//
// Copyright © 2021 Alexander Romanov
// FieldButtonStyle.swift, created on 21.02.2023
//

import SwiftUI

public struct FieldButtonStyle: ButtonStyle {
    @Environment(\.theme) private var theme: ThemeSettings
    @Environment(\.fieldPosition) private var fieldPosition: FieldPosition

    public init() {}

    public func makeBody(configuration: Self.Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.label
                .headline(.medium)
                .hLeading()
        }
        .padding()
        .background(fieldBackground(isPressed: configuration.isPressed))
    }

    @ViewBuilder
    private func fieldBackground(isPressed: Bool) -> some View {
        switch fieldPosition {
        case .default:
            RoundedRectangle(cornerRadius: Radius.medium, style: .continuous)
                .fill(isPressed ? Color.surfaceTertiary : Color.surfaceSecondary)
                .overlay(
                    RoundedRectangle(cornerRadius: Radius.medium,
                                     style: .continuous)
                        .stroke(theme.borderTextFields
                            ? Color.border
                            : Color.surfaceSecondary, lineWidth: CGFloat(theme.borderSize))
                )
        case .top, .bottom, .center:
            #if os(iOS)
            RoundedRectangleCorner(radius: Radius.medium, corners: backgroundShapeCorners)
                .fill(isPressed ? Color.surfaceTertiary : Color.surfaceSecondary)
                .overlay(
                    RoundedRectangleCorner(radius: Radius.medium, corners: backgroundShapeCorners)
                        .stroke(theme.borderTextFields
                            ? Color.border
                            : Color.surfaceSecondary, lineWidth: CGFloat(theme.borderSize))
                )
            #else
            RoundedRectangle(cornerRadius: Radius.medium, style: .continuous)
                .fill(isPressed ? Color.surfaceTertiary : Color.surfaceSecondary)
                .overlay(
                    RoundedRectangle(cornerRadius: Radius.medium,
                                     style: .continuous)
                        .stroke(theme.borderTextFields
                            ? Color.border
                            : Color.surfaceSecondary, lineWidth: CGFloat(theme.borderSize))
                )
            #endif
        }
    }

    #if os(iOS)
    @available(macOS, unavailable)
    @available(watchOS, unavailable)
    @available(tvOS, unavailable)
    private var backgroundShapeCorners: UIRectCorner {
        switch fieldPosition {
        case .default:
            [.allCorners]
        case .top:
            [.topLeft, .topRight]
        case .bottom:
            [.bottomLeft, .bottomRight]
        case .center:
            []
        }
    }
    #endif
}

public extension ButtonStyle where Self == FieldButtonStyle {
    static var field: FieldButtonStyle {
        FieldButtonStyle()
    }
}
