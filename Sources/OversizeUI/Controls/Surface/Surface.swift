//
// Copyright © 2021 Alexander Romanov
// Created on 15.11.2021
//

import SwiftUI

public enum SurfaceColor: Int, CaseIterable {
    case primary
    case secondary
    case tertiary
}

// swiftlint:disable opening_brace
public struct Surface<Label: View>: View {
    @ObservedObject var appearanceSettings = AppearanceSettings.shared
    @Environment(\.elevation) private var elevation: Elevation

    private enum Constants {
        /// Colors
        static var colorPrimary: Color { Color.surfacePrimary }
        static var colorSecondary: Color { Color.surfaceSecondary }
        static var colorTertiary: Color { Color.surfaceTertiary }
    }

    public var padding: Space

    private let label: Label

    public var backgroundColor: Color = Constants.colorPrimary

    public var background: SurfaceColor

    public var radius: Radius

    public var border: Color?

    private let action: (() -> Void)?

    public init(background: SurfaceColor = .primary,
                padding: Space = .medium,
                radius: Radius = .medium,
                border: Color? = nil,
                action: (() -> Void)? = nil,
                @ViewBuilder label: () -> Label)
    {
        self.label = label()
        self.padding = padding
        self.background = background
        self.radius = radius
        self.border = border
        self.action = action
        setBackground(background)
    }

    public init(background: SurfaceColor = .primary,
                action: (() -> Void)? = nil,
                @ViewBuilder label: () -> Label)
    {
        self.label = label()
        padding = .medium
        self.background = background
        radius = .medium
        self.action = action
        setBackground(background)
    }

    public init(
        action: (() -> Void)? = nil,
        @ViewBuilder label: () -> Label
    ) {
        self.label = label()
        padding = .medium
        background = .primary
        radius = .medium
        self.action = action
        setBackground(background)
    }

    public var body: some View {
        actionableSurface()
    }

    @ViewBuilder
    private func actionableSurface() -> some View {
        if action != nil {
            Button {
                (action)?()
            } label: {
                surface
            }
            .buttonStyle(SurfaceButtonStyle())
        } else {
            surface
        }
    }

    public var surface: some View {
        label
            .padding(.all, padding.rawValue)
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
                    .shadowElevaton(elevation)
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

public struct SurfaceButtonStyle: ButtonStyle {
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
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
