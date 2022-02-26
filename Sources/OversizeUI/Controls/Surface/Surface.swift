//
// Copyright © 2022 Alexander Romanov
// Surface.swift
//

import SwiftUI

public enum SurfaceStyle: Int, CaseIterable {
    case primary
    case secondary
    case tertiary
    case clear
}

// swiftlint:disable opening_brace
public struct Surface<Label: View>: View {
    @Environment(\.elevation) private var elevation: Elevation
    @Environment(\.theme) private var theme: ThemeSettings
    @Environment(\.controlRadius) var controlRadius: Radius
    @Environment(\.controlPadding) var controlPadding: Space

    private enum Constants {
        /// Colors
        static var colorPrimary: Color { Color.surfacePrimary }
        static var colorSecondary: Color { Color.surfaceSecondary }
        static var colorTertiary: Color { Color.surfaceTertiary }
    }

    private let label: Label
    private let action: (() -> Void)?
    private var background: SurfaceStyle = .primary
    private var border: Color?

    public init(action: (() -> Void)? = nil,
                @ViewBuilder label: () -> Label)
    {
        self.label = label()
        self.action = action
    }

    public var body: some View {
        if action != nil {
            actionableSurface
        } else {
            surface
        }
    }

    private var actionableSurface: some View {
        Button {
            action?()
        } label: {
            surface
        }
        .buttonStyle(SurfaceButtonStyle())
    }

    private var surface: some View {
        label
            .padding(.all, controlPadding.rawValue)
            .background(
                RoundedRectangle(cornerRadius: controlRadius.rawValue,
                                 style: .circular)
                    .fill(backgroundColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: controlRadius.rawValue,
                                         style: .continuous)
                            .stroke(
                                border != nil ? border ?? Color.clear
                                    : theme.borderSurface
                                    ? Color.border
                                    : backgroundColor, lineWidth: CGFloat(theme.borderSize)
                            )
                    )
                    .shadowElevaton(elevation)
            )
    }

    private var backgroundColor: Color {
        switch background {
        case .primary:
            return Constants.colorPrimary
        case .secondary:
            return Constants.colorSecondary
        case .tertiary:
            return Constants.colorTertiary
        case .clear:
            return Color.clear
        }
    }

    public func surfaceStyle(_ style: SurfaceStyle) -> Surface {
        var control = self
        control.background = style
        return control
    }

    public func surfaceBorderColor(_ border: Color?) -> Surface {
        var control = self
        control.border = border
        return control
    }
}

public struct SurfaceButtonStyle: ButtonStyle {
    public init() {}

    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

struct Surface_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Surface {
                Text("Text")
                    .fontStyle(.title3, color: .onSurfaceHighEmphasis)
            }
            .surfaceStyle(.secondary)
            .previewLayout(.fixed(width: 414, height: 200))

            Surface {
                Text("Text")
                    .fontStyle(.title3, color: .onSurfaceHighEmphasis)
            }
            .surfaceStyle(.primary)
            .surfaceBorderColor(.surfaceSecondary)
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

            Surface { HStack {
                Spacer()
                Text("Text")
                Spacer()
            }}
            .surfaceStyle(.primary)
            .elevation(.z2)
            .controlRadius(.zero)
            .controlPadding(.zero)
            .previewLayout(.fixed(width: 375, height: 200))

            Surface { HStack {
                Text("Text")
                Spacer()
            }}
            .elevation(.z1)
            .controlPadding(.large)
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 320, height: 200))
        }
        .padding()
    }
}
