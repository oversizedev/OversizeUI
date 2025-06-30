//
// Copyright © 2021 Alexander Romanov
// Button.swift, created on 10.02.2021
//

import SwiftUI

/// Semantic button types that define visual hierarchy and user interaction patterns.
///
/// Use these button types to create consistent visual hierarchy in your interface:
/// - Use ``primary`` for the main call-to-action
/// - Use ``secondary`` for important but alternative actions  
/// - Use ``tertiary`` for supplementary actions
/// - Use ``quaternary`` for minimal actions with low visual weight
///
/// ```swift
/// Button("Save") { save() }
///     .buttonStyle(.primary)
/// 
/// Button("Cancel") { cancel() }
///     .buttonStyle(.tertiary)
/// ```
public enum ButtonType: Int, CaseIterable {
    /// Primary button style for main call-to-action buttons.
    case primary
    
    /// Secondary button style for important alternative actions.
    case secondary
    
    /// Tertiary button style for supplementary actions.
    case tertiary
    
    /// Quaternary button style for minimal actions with low visual weight.
    case quaternary
}

/// A comprehensive button style that provides semantic styling with theme integration.
///
/// `OversizeButtonStyle` implements the design system's button styling with support for:
/// - Multiple button types (primary, secondary, tertiary, quaternary)
/// - Loading states with spinner overlays
/// - Accessibility features including proper contrast and touch targets
/// - Theme integration with accent colors and customization
/// - Platform-appropriate styling and behavior
///
/// The button style automatically adapts to:
/// - Light and dark appearance modes
/// - Different control sizes (mini, small, regular, large)
/// - Accessibility settings like increased contrast and Dynamic Type
/// - Platform conventions (iOS, macOS, tvOS, watchOS)
///
/// ```swift
/// Button("Primary Action") { performAction() }
///     .buttonStyle(.primary)
///     .controlSize(.large)
///     .accent()
/// ```
///
/// ## Topics
///
/// ### Creating Button Styles
/// - ``init(_:infinityWidth:)``
/// - ``ButtonType``
///
/// ### Styling Options
/// - ``accent()``
/// - ``bordered()``
/// - ``loading(_:)``
///
/// ## See Also
/// - <doc:Components/Button>
/// - ``ButtonType``
public struct OversizeButtonStyle: ButtonStyle {
    /// Environment values for theme customization.
    @Environment(\.theme) private var theme: ThemeSettings
    
    /// Environment value indicating if the button is enabled.
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    /// Environment value indicating if the button is in loading state.
    @Environment(\.isLoading) private var isLoading: Bool
    
    /// Environment value indicating if accent styling should be applied.
    @Environment(\.isAccent) private var isAccent: Bool
    
    /// Environment value for the button's elevation/shadow level.
    @Environment(\.elevation) private var elevation: Elevation
    
    /// Environment value for the button's border shape.
    @Environment(\.controlBorderShape) var controlBorderShape: ControlBorderShape
    
    /// Environment value indicating if the button should have a border.
    @Environment(\.isBordered) var isBordered: Bool
    
    #if !os(tvOS)
    /// Environment value for the button's control size.
    @Environment(\.controlSize) var controlSize: ControlSize
    #endif

    /// The semantic type of button determining its visual style.
    private let type: ButtonType
    
    /// Whether the button should expand to fill available width.
    private let isInfinityWidth: Bool?

    /// Creates a button style with the specified type and width behavior.
    ///
    /// - Parameters:
    ///   - type: The semantic button type determining visual hierarchy
    ///   - infinityWidth: Whether the button should expand to fill available width
    public init(_ type: ButtonType, infinityWidth: Bool? = nil) {
        self.type = type
        isInfinityWidth = infinityWidth
    }

    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .body(.semibold)
            .opacity(isLoading ? 0 : 1)
            .foregroundColor(foregroundColor(for: configuration.role).opacity(foregroundOpacity))
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, verticalPadding)
            .frame(maxWidth: maxWidth)
            .background(background(for: configuration.role))
            .overlay(loadingView(for: configuration.role))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .shadowElevation(isEnabled ? elevation : .z0)
    }

    @ViewBuilder
    private func background(for role: ButtonRole?) -> some View {
        if type != .quaternary {
            switch controlBorderShape {
            case .capsule:
                Capsule()
                    .fill(backgroundColor(for: role)
                        .opacity(backgroundOpacity))
                    .overlay {
                        Capsule()
                            .strokeBorder(Color.onSurfacePrimary.opacity(0.15), lineWidth: 2)
                            .opacity(isBordered || theme.borderButtons ? 1 : 0)
                    }

            case let .roundedRectangle(radius):
                RoundedRectangle(cornerRadius: radius != .medium ? radius.rawValue : theme.radius, style: .continuous)
                    .fill(backgroundColor(for: role)
                        .opacity(backgroundOpacity))
                    .overlay {
                        RoundedRectangle(cornerRadius: radius != .medium ? radius.rawValue : theme.radius, style: .continuous)
                            .strokeBorder(Color.onSurfacePrimary.opacity(0.15), lineWidth: 2)
                            .opacity(isBordered || theme.borderButtons ? 1 : 0)
                    }
            }
        }
    }

    /// Parameters
    private func backgroundColor(for role: ButtonRole?) -> Color {
        switch type {
        case .primary:
            switch role {
            case .some(.destructive): Color.error
            case .some(.cancel): Color.accent
            default:
                if isAccent {
                    Color.accent
                } else {
                    Color.primary
                }
            }
        case .secondary:
            Color.surfacePrimary
        case .tertiary:
            Color.surfaceSecondary
        case .quaternary:
            Color.clear
        }
    }

    private func foregroundColor(for role: ButtonRole?) -> Color {
        switch type {
        case .primary:
            switch role {
            case .some(.destructive), .some(.cancel): Color.onPrimary
            default:
                if isAccent {
                    Color.onPrimary
                } else {
                    Color.backgroundPrimary
                }
            }
        case .secondary, .quaternary:
            switch role {
            case .some(.destructive): Color.error
            case .some(.cancel): Color.accent
            default:
                if isAccent {
                    Color.accent
                } else {
                    Color.onSurfacePrimary
                }
            }
        case .tertiary:
            switch role {
            case .some(.destructive): Color.error
            case .some(.cancel): Color.onSurfacePrimary
            default:
                if isAccent {
                    Color.accent
                } else {
                    Color.onSurfacePrimary
                }
            }
        }
    }

    @ViewBuilder
    private func loadingView(for role: ButtonRole?) -> some View {
        if isLoading {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: foregroundColor(for: role)))
        } else {
            EmptyView()
        }
    }

    private var horizontalPadding: Space {
        #if os(tvOS)
        return .medium
        #else
        switch controlSize {
        case .mini:
            switch controlBorderShape {
            case .capsule:
                return .xSmall
            case .roundedRectangle:
                return .xxSmall
            }
        case .small:
            return .small
        case .regular:
            return .small
        case .large, .extraLarge:
            return .medium
        @unknown default:
            return .zero
        }
        #endif
    }

    private var verticalPadding: Space {
        #if os(tvOS)
        return .medium
        #else
        switch controlSize {
        case .mini:
            return .xxxSmall
        case .small:
            return .xxSmall
        case .regular:
            return .xSmall
        case .large:
            return .small
        case .extraLarge:
            return .medium
        @unknown default:
            return .zero
        }
        #endif
    }

    private var backgroundOpacity: CGFloat {
        isEnabled ? 1 : 0.5
    }

    private var foregroundOpacity: CGFloat {
        isEnabled ? 1 : 0.7
    }

    private var maxWidth: CGFloat? {
        #if os(tvOS)
        return nil
        #else
        if isInfinityWidth == nil, controlSize == .regular {
            return .infinity
        } else if let infinity = isInfinityWidth, infinity == true {
            return .infinity
        } else {
            return nil
        }
        #endif
    }
}

public extension ButtonStyle where Self == OversizeButtonStyle {
    static var primary: OversizeButtonStyle {
        OversizeButtonStyle(.primary)
    }

    static var secondary: OversizeButtonStyle {
        OversizeButtonStyle(.secondary)
    }

    static var tertiary: OversizeButtonStyle {
        OversizeButtonStyle(.tertiary)
    }

    static var quaternary: OversizeButtonStyle {
        OversizeButtonStyle(.quaternary)
    }

    static func primary(infinityWidth: Bool?) -> OversizeButtonStyle {
        OversizeButtonStyle(.primary, infinityWidth: infinityWidth)
    }

    static func secondary(infinityWidth: Bool?) -> OversizeButtonStyle {
        OversizeButtonStyle(.secondary, infinityWidth: infinityWidth)
    }

    static func tertiary(infinityWidth: Bool?) -> OversizeButtonStyle {
        OversizeButtonStyle(.tertiary, infinityWidth: infinityWidth)
    }

    static func quaternary(infinityWidth: Bool?) -> OversizeButtonStyle {
        OversizeButtonStyle(.quaternary, infinityWidth: infinityWidth)
    }
}

@available(tvOS, unavailable)
struct OversizeButtonStyle_Previews: PreviewProvider {
    struct Buttons: View {
        var body: some View {
            Group {
                Button(role: .cancel) {} label: {
                    Text("Button")
                }
                .buttonStyle(.primary)

                Button(role: .destructive) {} label: {
                    Text("Button")
                }
                .buttonStyle(.primary)

                Button {} label: {
                    Text("Button")
                }
                .buttonStyle(.primary)

                Button(role: .cancel) {} label: {
                    Text("Button")
                }
                .buttonStyle(OversizeButtonStyle(.secondary))

                Button(role: .destructive) {} label: {
                    Text("Button")
                }
                .buttonStyle(OversizeButtonStyle(.secondary))

                Button {} label: {
                    Text("Button")
                }
                .buttonStyle(OversizeButtonStyle(.secondary))
            }
            Group {
                Button(role: .cancel) {} label: {
                    Text("Button")
                }
                .buttonStyle(OversizeButtonStyle(.tertiary))

                Button(role: .destructive) {} label: {
                    Text("Button")
                }
                .buttonStyle(OversizeButtonStyle(.tertiary))

                Button {} label: {
                    Text("Button")
                }
                .buttonStyle(OversizeButtonStyle(.tertiary))

                Button(role: .cancel) {} label: {
                    Text("Button")
                }
                .buttonStyle(OversizeButtonStyle(.quaternary))

                Button(role: .destructive) {} label: {
                    Text("Button")
                }
                .buttonStyle(OversizeButtonStyle(.quaternary))

                Button {} label: {
                    Text("Button")
                }

                .buttonStyle(OversizeButtonStyle(.quaternary))
            }
        }
    }

    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Large")
                    .title()

                Button(role: .cancel) {} label: {
                    Text("Button")
                }
                .buttonStyle(OversizeButtonStyle(.primary))
                .controlSize(.large)

                HStack {
                    VStack(spacing: 16) {
                        Buttons()
                    }
                    .controlBorderShape(.capsule)

                    VStack(spacing: 16) {
                        Buttons()
                    }
                    .accent()
                    .bordered()

                    VStack(spacing: 16) {
                        Buttons()
                    }
                    .disabled(true)
                }
                .controlSize(.large)

                Text("Regular")
                    .title()

                Button(role: .cancel) {} label: {
                    Text("Button")
                }
                .buttonStyle(OversizeButtonStyle(.primary))

                HStack {
                    VStack(spacing: 16) {
                        Buttons()
                    }
                    .controlBorderShape(.capsule)

                    VStack(spacing: 16) {
                        Buttons()
                    }
                    .accent()
                    .bordered()

                    VStack(spacing: 16) {
                        Buttons()
                    }
                    .disabled(true)
                }

                Text("Small")
                    .bold()
                    .title()

                HStack {
                    VStack(spacing: 16) {
                        Buttons()
                    }
                    .controlBorderShape(.capsule)

                    VStack(spacing: 16) {
                        Buttons()
                    }
                    .accent()
                    .bordered()

                    VStack(spacing: 16) {
                        Buttons()
                    }
                    .disabled(true)

                    VStack(spacing: 16) {
                        Buttons()
                    }
                    .accent()
                    .disabled(true)
                }
                .controlSize(.small)

                Text("Mini")
                    .title()

                HStack {
                    VStack(spacing: 16) {
                        Buttons()
                    }
                    .controlBorderShape(.capsule)

                    VStack(spacing: 16) {
                        Buttons()
                    }
                    .accent()
                    .bordered()

                    VStack(spacing: 16) {
                        Buttons()
                    }
                    .disabled(true)

                    VStack(spacing: 16) {
                        Buttons()
                    }
                    .accent()
                    .disabled(true)
                }
                .controlSize(.mini)
            }
            .padding()
        }
        .previewLayout(.sizeThatFits)
    }
}
