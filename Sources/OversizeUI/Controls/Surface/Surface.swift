//
// Copyright © 2021 Alexander Romanov
// Created on 02.10.2021
//

import SwiftUI

public enum SurfaceColor: Int, CaseIterable {
    case primary
    case secondary
    case tertiary
}

public enum SurfacePadding: Int, CaseIterable {
    case xxxSmall
    case xxSmall
    case medium
    case small
    case zero
}

// swiftlint:disable opening_brace
public struct Surface<Content: View>: View {
    @ObservedObject var appearanceSettings = AppearanceSettings.shared

    private enum Constants {
        /// Colors
        static var colorPrimary: Color { Color.surfacePrimary }
        static var colorSecondary: Color { Color.surfaceSecondary }
        static var colorTertiary: Color { Color.surfaceTertiary }

        /// Size
        static var paddingMedium: CGFloat { Space.medium.rawValue }
        static var paddingSmall: CGFloat { Space.small.rawValue }
        static var paddingXXXSmall: CGFloat { Space.xxxSmall.rawValue }
        static var paddingXXSmall: CGFloat { Space.xxSmall.rawValue }
        static var paddingZero: CGFloat { .zero }
    }

    public var padding: SurfacePadding = .xxxSmall

    private let content: Content

    public var backgroundColor: Color = Constants.colorPrimary

    public var background: SurfaceColor

    public var radius: Radius

    public var border: Color?

    public init(background: SurfaceColor = .primary,
                padding: SurfacePadding = .medium,
                radius: Radius = .medium,
                border: Color? = nil,
                @ViewBuilder content: () -> Content)
    {
        self.content = content()
        self.padding = padding
        self.background = background
        self.radius = radius
        self.border = border
        setBackground(background)
    }

    public init(background: SurfaceColor = .primary,
                @ViewBuilder content: () -> Content)
    {
        self.content = content()
        padding = .medium
        self.background = background
        radius = .medium
        setBackground(background)
    }

    public var body: some View {
        content
            .padding(.all,
                     padding == .xxxSmall ? Constants.paddingXXXSmall
                         : padding == .xxSmall ? Constants.paddingXXSmall
                         : padding == .small ? Constants.paddingSmall
                         : padding == .medium ? Constants.paddingMedium
                         : Constants.paddingZero)
            .background(
                RoundedRectangle(cornerRadius: radius.rawValue,
                                 style: .circular)
                    .fill(backgroundColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: radius.rawValue,
                                         style: .continuous)
                            .stroke(
                                border != nil ? border ?? Color.clear
                                    : appearanceSettings.borderSurface
                                    ? Color.border
                                    : backgroundColor, lineWidth: CGFloat(appearanceSettings.borderSize)
                            )
                    )
            )
    }

    private mutating func setBackground(_ background: SurfaceColor) {
        switch background {
        case .primary:
            backgroundColor = Constants.colorPrimary
        case .secondary:
            backgroundColor = Constants.colorSecondary
        case .tertiary:
            backgroundColor = Constants.colorTertiary
        }
    }
}

struct Surface_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Surface(background: .secondary) {
                Text("Text")
                    .fontStyle(.title3, color: .onSurfaceHighEmphasis)
            }
            .previewLayout(.fixed(width: 414, height: 200))

            Surface(background: .primary, border: .surfaceSecondary) {
                Text("Text")
                    .fontStyle(.title3, color: .onSurfaceHighEmphasis)
            }
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 414, height: 200))

            Text("Text")
                .surface(elevation: .z4)
                .previewLayout(.fixed(width: 414, height: 200))

            HStack {
                Text("Text")

                Spacer()
            }
            .surface(elevation: .z4)
            .previewLayout(.fixed(width: 414, height: 200))

            Surface(background: .primary, padding: .zero, radius: .zero) { HStack {
                Spacer()
                Text("Text")
                Spacer()
            }}
            .elevation(.z2)
            .previewLayout(.fixed(width: 375, height: 200))

            Surface { HStack {
                Text("Text")
                Spacer()
            }}
            .elevation(.z1)
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 320, height: 200))
        }
        .padding()
    }
}
