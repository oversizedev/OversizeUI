//
// Copyright © 2021 Alexander Romanov
// Surface.swift, created on 14.05.2020
//

import SwiftUI

public enum SurfaceStyle {
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
    @Environment(\.surfaceContentInsets) var contentInsets: EdgeSpaceInsets
    @Environment(\.isAccent) private var isAccent: Bool

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
            .padding(.top, contentInsets.top)
            .padding(.bottom, contentInsets.bottom)
            .padding(.leading, contentInsets.leading)
            .padding(.trailing, contentInsets.trailing)
            .background(
                RoundedRectangle(cornerRadius: controlRadius, style: .continuous)
                    .fill(surfaceBackgroundColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: controlRadius, style: .continuous)
                            .strokeBorder(strokeBorderColor, lineWidth: strokeBorderLineWidth)
                    )
                    .shadowElevaton(elevation)
            )
            .clipShape(
                RoundedRectangle(cornerRadius: controlRadius, style: .continuous)
            )
    }

    private var strokeBorderColor: Color {
        if let border {
            return border
        } else {
            if theme.borderSurface {
                return Color.border
            } else {
                return surfaceBackgroundColor
            }
        }
    }

    private var strokeBorderLineWidth: CGFloat {
        if let borderWidth {
            return borderWidth
        } else {
            return CGFloat(theme.borderSize)
        }
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
            .scaleEffect(configuration.isPressed ? 0.96 : 1)
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
        VStack {
            Surface {
                RowDeprecated("Title") {}
            }
            .surfaceStyle(.primary)
            .previewLayout(.fixed(width: 414, height: 300))

            Surface {
                Text("Text")
                    .title3()
                    .onSurfaceHighEmphasisForegroundColor()
            }
            .surfaceStyle(.secondary)
            .previewLayout(.fixed(width: 414, height: 200))

            Surface {
                Text("Text")
                    .title3()
                    .onSurfaceHighEmphasisForegroundColor()
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
            .previewLayout(.fixed(width: 375, height: 200))

            Surface { HStack {
                Text("Text")
                Spacer()
            }}
            .elevation(.z1)
            .surfaceContentInsets(.large)
            .previewLayout(.fixed(width: 320, height: 200))
        }
        .padding()
    }
}
