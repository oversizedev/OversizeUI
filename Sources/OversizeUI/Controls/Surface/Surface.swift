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
    @Environment(\.controlPadding) var controlPadding: ControlPadding
    @Environment(\.isAccent) private var isAccent

    private enum Constants {
        /// Colors
        static var colorPrimary: Color { Color.surfacePrimary }
        static var colorSecondary: Color { Color.surfaceSecondary }
        static var colorTertiary: Color { Color.surfaceTertiary }
    }

    private let label: Label
    private let action: (() -> Void)?
    private var background: SurfaceStyle = .primary
    private var backgroundColor: Color?
    private var border: Color?
    private var borderWidth: CGFloat?

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
            .padding(.horizontal, controlPadding.horizontal)
            .padding(.vertical, controlPadding.vertical)
            .background(
                RoundedRectangle(cornerRadius: controlRadius,
                                 style: .continuous)
                    .fill(surfaceBackgroundColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: controlRadius,
                                         style: .continuous)
                            .strokeBorder(
                                border != nil ? border ?? Color.clear
                                    : theme.borderSurface
                                    ? Color.border
                                    : surfaceBackgroundColor, lineWidth: borderWidth != nil ? borderWidth ?? 0 : CGFloat(theme.borderSize)
                            )
                    )
                    .shadowElevaton(elevation)
            )
            .clipShape(
                RoundedRectangle(cornerRadius: controlRadius, style: .continuous)
            )
    }

    private var surfaceBackgroundColor: Color {
        if let backgroundColor {
            return backgroundColor
        } else if isAccent {
            return Color.accent
        } else {
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
    }

    public func surfaceStyle(_ style: SurfaceStyle) -> Surface {
        var control = self
        control.background = style
        return control
    }

    public func surfaceBorderColor(_ border: Color? = Color.border) -> Surface {
        var control = self
        control.border = border
        return control
    }

    public func surfaceBorderWidth(_ width: CGFloat) -> Surface {
        var control = self
        control.borderWidth = width
        return control
    }

    public func surfaceBackgroundColor(_ color: Color?) -> Surface {
        var control = self
        control.backgroundColor = color
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

// swiftlint:disable opening_brace
public extension View {
    func surface() -> some View {
        Surface { self }
    }

    func surface(_ elevation: Elevation) -> some View {
        Surface { self }
            .elevation(elevation)
    }

    func surface(_ elevation: Elevation, background: SurfaceStyle) -> some View {
        Surface { self }
            .surfaceStyle(background)
            .elevation(elevation)
    }

    @available(*, deprecated, message: "Use without elevation")
    func surface(elevation: Elevation) -> some View {
        Surface { self }
            .elevation(elevation)
    }

    @available(*, deprecated, message: "Use without elevation")
    func surface(elevation: Elevation, background: SurfaceStyle) -> some View {
        Surface { self }
            .surfaceStyle(background)
            .elevation(elevation)
    }

    @available(*, deprecated, message: "Use without elevation")
    func surface(elevation: Elevation = .z0,
                 background: SurfaceStyle = .primary,
                 padding: Space = .medium,
                 radius: Radius = .medium) -> some View
    {
        Surface { self }
            .surfaceStyle(background)
            .controlPadding(padding)
            .controlRadius(radius)
            .elevation(elevation)
    }
}

struct Surface_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Surface {
                Text("Text")
                    .title3()
                    .foregroundOnSurfaceHighEmphasis()
            }
            .surfaceStyle(.secondary)
            .previewLayout(.fixed(width: 414, height: 200))

            Surface {
                Text("Text")
                    .title3()
                    .foregroundOnSurfaceHighEmphasis()
            }
            .surfaceStyle(.primary)
            .surfaceBorderColor(.surfaceSecondary)
            .preferredColorScheme(.dark)
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
