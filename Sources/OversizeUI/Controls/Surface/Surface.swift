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
    @Environment(\.theme) private var theme: ThemeSettings
    @Environment(\.isAccent) private var isAccent: Bool
    @Environment(\.surfaceRadius) var surfaceRadius: Radius
    @Environment(\.surfaceContentMargins) var contentInsets: EdgeSpaceInsets
    @Environment(\.surfaceElevation) private var elevation: Elevation

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
    private let forceContentInsets: EdgeSpaceInsets?
    private var isSurfaceClipped: Bool = false

    @State var isHover = false

    public init(
        action: (() -> Void)? = nil,
        @ViewBuilder label: () -> Label
    ) {
        self.label = label()
        self.action = action
        forceContentInsets = nil
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
                .contentShape(Rectangle())
        }
        .buttonStyle(SurfaceButtonStyle())
        #if os(macOS)
            .onHover { hover in
                isHover = hover
            }
        #endif
    }

    private var surface: some View {
        label
            .padding(.top, forceContentInsets?.top ?? contentInsets.top)
            .padding(.bottom, forceContentInsets?.bottom ?? contentInsets.bottom)
            .padding(.leading, forceContentInsets?.leading ?? contentInsets.leading)
            .padding(.trailing, forceContentInsets?.trailing ?? contentInsets.trailing)
            .background {
                #if os(macOS)
                ZStack {
                    RoundedRectangle(
                        cornerRadius: surfaceRadius,
                        style: .continuous
                    )
                    .fill(surfaceBackgroundColor)
                    .shadowElevaton(elevation)

                    if isHover {
                        RoundedRectangle(
                            cornerRadius: surfaceRadius,
                            style: .continuous
                        )
                        .fill(Color.onSurfaceTertiary.opacity(0.04))
                    }
                }
                #else
                RoundedRectangle(
                    cornerRadius: surfaceRadius,
                    style: .continuous
                )
                .fill(surfaceBackgroundColor)
                .shadowElevaton(elevation)
                #endif
            }
            .overlay(
                RoundedRectangle(
                    cornerRadius: surfaceRadius,
                    style: .continuous
                )
                .strokeBorder(
                    strokeBorderColor,
                    lineWidth: strokeBorderLineWidth
                )
            )
            .if(isSurfaceClipped) { view in
                view.clipShape(
                    RoundedRectangle(
                        cornerRadius: surfaceRadius,
                        style: .continuous
                    )
                )
            }
    }

    private var strokeBorderColor: Color {
        if let border {
            border
        } else {
            if theme.borderSurface {
                Color.border
            } else {
                surfaceBackgroundColor
            }
        }
    }

    private var strokeBorderLineWidth: CGFloat {
        if let borderWidth {
            borderWidth
        } else {
            CGFloat(theme.borderSize)
        }
    }

    private var surfaceBackgroundColor: Color {
        if let backgroundColor {
            backgroundColor
        } else if isAccent {
            Color.accent
        } else {
            switch background {
            case .primary:
                Constants.colorPrimary
            case .secondary:
                Constants.colorSecondary
            case .tertiary:
                Constants.colorTertiary
            case .clear:
                Color.clear
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

    public func surfaceClip(_ surfaceClipped: Bool = true) -> Surface {
        var control = self
        control.isSurfaceClipped = surfaceClipped
        return control
    }
}

public struct SurfaceButtonStyle: ButtonStyle {
    public init() {}

    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
        #if os(macOS)
            .scaleEffect(configuration.isPressed ? 0.99 : 1)
        #else
            .scaleEffect(configuration.isPressed ? 0.96 : 1)
        #endif
    }
}

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

public extension Surface where Label == VStack<TupleView<(Row<Image, EmptyView>, Row<Image, EmptyView>)>> {
    init(action: (() -> Void)? = nil,
         @ViewBuilder label: () -> Label)
    {
        self.label = label()
        self.action = action
        forceContentInsets = .init(horizontal: .zero, vertical: .small)
    }
}

public extension Surface where Label == Row<EmptyView, EmptyView> {
    init(action: (() -> Void)? = nil,
         @ViewBuilder label: () -> Label)
    {
        self.label = label()
        self.action = action
        forceContentInsets = .init(horizontal: .zero, vertical: .small)
    }
}

public extension Surface where Label == Row<Image, EmptyView> {
    init(action: (() -> Void)? = nil,
         @ViewBuilder label: () -> Label)
    {
        self.label = label()
        self.action = action
        forceContentInsets = .init(horizontal: .zero, vertical: .small)
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
                    .onSurfacePrimaryForeground()
            }
            .surfaceStyle(.secondary)
            .previewLayout(.fixed(width: 414, height: 200))

            Surface {
                Text("Text")
                    .title3()
                    .onSurfacePrimaryForeground()
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
            .surfaceContentMargins(.large)
            .previewLayout(.fixed(width: 320, height: 200))
        }
        .padding()
    }
}
