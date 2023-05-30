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
    @Environment(\.surfaceRadius) var surfaceRadius: Radius
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
    

    public init<LeadingLabel, TrailingLabel>(
        action: (() -> Void)? = nil,
        @ViewBuilder label: () -> Label) where Label == Row<LeadingLabel, TrailingLabel>, LeadingLabel: View, TrailingLabel: View {
            self.label = label()
            self.action = action
            self.backgroundColor = .red
        }
    
    public init<LeadingLabel, TrailingLabel>(
        @ViewBuilder label: () -> Label) where Label == Row<LeadingLabel, TrailingLabel>, LeadingLabel: View, TrailingLabel: View {
            self.label = label()
            self.action = nil
            self.backgroundColor = .red
        }
    
//    public init<LeadingLabel, TrailingLabel>(
//        @ViewBuilder label: () -> Label) where Label == Row<LeadingLabel, TrailingLabel>, LeadingLabel: View, TrailingLabel: Never {
//            self.label = label()
//            self.action = nil
//            self.backgroundColor = .red
//        }
    
//    public init<LeadingLabel, TrailingLabel>(
//        action: (() -> Void)? = nil,
//        @ViewBuilder label: () -> Label) where Label == Row<LeadingLabel, TrailingLabel>, LeadingLabel: View, TrailingLabel: View
//    {
//        self.label = label()
//        self.action = action
//        self.backgroundColor = .red
//    }
    
//    public init<I, P>(
//        url: URL?,
//        scale: CGFloat = 1,
//        @ViewBuilder content: @escaping (Image) -> I,
//        @ViewBuilder placeholder: @escaping () -> P) where Content == _ConditionalContent<I, P>, I : View, P : View

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
                RoundedRectangle(cornerRadius: surfaceRadius, style: .continuous)
                    .fill(surfaceBackgroundColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: surfaceRadius, style: .continuous)
                            .strokeBorder(strokeBorderColor, lineWidth: strokeBorderLineWidth)
                    )
                    .shadowElevaton(elevation)
            )
            .clipShape(
                RoundedRectangle(cornerRadius: surfaceRadius, style: .continuous)
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

// extension Optional : View where Wrapped : View {
//Anchor : Hashable where Value : Hashable {

// where Content == PresentedWindowContent<D, C>, D : Decodable, D : Encodable, D : Hashable, C : View
//     public init<D, C>(id: String, for type: D.Type, @ViewBuilder content: @escaping (Binding<D?>) -> C) where Content == PresentedWindowContent<D, C>, D : Decodable, D : Encodable, D : Hashable, C : View
//public extension Surface where Label == Row<some View, some View> {

//extension ExclusiveGesture.Value : Equatable where First.Value : Equatable, Second.Value : Equatable {
    
//    init<LeadingLabel, TrailingLabel>(
//        action: (() -> Void)? = nil,
//        @ViewBuilder label: @escaping () -> (LeadingLabel, TrailingLabel)) where Label == Row<LeadingLabel, TrailingLabel>, LeadingLabel: View, TrailingLabel : View
    
//public extension Surface where Label == Row<LeadingLabel, TrailingLabel>: View, LeadingLabel: View, TrailingLabel: View   {
//extension ForEach where Data == Range<Int>, ID == Int, Content : View {
//
//
//    extension ForEach where Data == Range<Int>, ID == Int, Content : View {
//
//        /// Creates an instance that computes views on demand over a given constant
//        /// range.
//        ///
//        /// The instance only reads the initial value of the provided `data` and
//        /// doesn't need to identify views across updates. To compute views on
//        /// demand over a dynamic range, use ``ForEach/init(_:id:content:)``.
//        ///
//        /// - Parameters:
//        ///   - data: A constant range.
//        ///   - content: The view builder that creates views dynamically.
//        public init(_ data: Range<Int>, @ViewBuilder content: @escaping (Int) -> Content)
//    }

////extension Surface where Label == Row: View, TrailingLabel: View> {
//
//extension Surface where Label == Row<View, View> {
//
//    public init<LeadingLabel, TrailingLabel>(
//        action: (() -> Void)? = nil,
//        @ViewBuilder label: () -> Label) where Label == Row<LeadingLabel, TrailingLabel>, LeadingLabel : View, TrailingLabel : View {
//            self.label = label()
//            self.action = action
//            self.backgroundColor = .red
//        }
//}

//extension Surface: View where Label == VStack<Row<EmptyView, EmptyView>> {
//
//    public init(action: (() -> Void)? = nil,
//                @ViewBuilder label: () -> Label)
//    {
//        self.label = label()
//        self.action = action
//        self.backgroundColor = .red
//    }
//}


//extension Surface where Label == VStack<Row<EmptyView, EmptyView>> {
//
//    public init(action: (() -> Void)? = nil,
//                @ViewBuilder label: () -> Label)
//    {
//        self.label = label()
//        self.action = action
//        self.backgroundColor = .red
//    }
//}

//extension Surface where Label == Row<LeadingLabel, TrailingLabel>, LeadingLabel: View, TrailingLabel: View {
//    public init<LeadingLabel, TrailingLabel>(
//        @ViewBuilder label: () -> Label) where Label == Row<LeadingLabel, TrailingLabel>, LeadingLabel: View, TrailingLabel: View {
//            self.label = label()
//            self.action = nil
//            self.backgroundColor = .red
//        }
//}

//extension Surface where Label == Row<EmptyView, EmptyView> {
//
//    public init(action: (() -> Void)? = nil,
//                @ViewBuilder label: () -> Label)
//    {
//        self.label = label()
//        self.action = action
//        self.backgroundColor = .red
//    }
//
//}

//extension Surface where Label == Row<A, B>, A: View, B: View {
//
//}

//extension Surface where Label == Row<LeadingLabel, TrailingLabel> {
//
//    public init(_ title: String,
//                subtitle: String? = nil,
//                action: (() -> Void)? = nil,
//                @ViewBuilder leading: () -> LeadingLabel,
//                @ViewBuilder trailing: () -> TrailingLabel)
//    {
//        self.title = title
//        self.subtitle = subtitle
//        self.action = action
//        leadingLabel = leading()
//        trailingLabel = trailing()
//        leadingSize = nil
//        leadingRadius = nil
//
//}


//public struct Row<LeadingLabel, TrailingLabel>: View where LeadingLabel: View, TrailingLabel: View {

//public init(_ title: String,
//            subtitle: String? = nil,
//            action: (() -> Void)? = nil,
//            @ViewBuilder leading: () -> LeadingLabel,
//            @ViewBuilder trailing: () -> TrailingLabel)
//{
//    self.title = title
//    self.subtitle = subtitle
//    self.action = action
//    leadingLabel = leading()
//    trailingLabel = trailing()
//    leadingSize = nil
//    leadingRadius = nil
//}

//extension TableColumn where RowValue == Sort.Compared, Label == Text {

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
