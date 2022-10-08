//
// Copyright © 2022 Alexander Romanov
// Button.swift
//

import SwiftUI

public enum ButtonType: Int, CaseIterable {
    case primary
    case secondary
    case tertiary
    case quaternary
}

public struct OversizeButtonStyle: ButtonStyle {
    @Environment(\.theme) private var theme: ThemeSettings
    @Environment(\.isEnabled) private var isEnabled: Bool
    @Environment(\.isLoading) private var isLoading: Bool
    @Environment(\.isAccent) private var isAccent: Bool
    @Environment(\.elevation) private var elevation: Elevation
    @Environment(\.controlSize) var controlSize: ControlSize
    @Environment(\.controlBorderShape) var controlBorderShape: ControlBorderShape
    @Environment(\.isBordered) var isBordered: Bool

    private let type: ButtonType
    private let isInfinityWidth: Bool?

    public init(_ type: ButtonType, infinityWidth: Bool? = nil) {
        self.type = type
        isInfinityWidth = infinityWidth
    }

    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .body(true)
            .opacity(isLoading ? 0 : 1)
            .foregroundColor(foregroundColor(for: configuration.role).opacity(foregroundOpacity))
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, verticalPadding)
            .frame(maxWidth: maxWidth)
            .background(background(for: configuration.role))
            .overlay(loadingView(for: configuration.role))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .shadowElevaton(elevation)
    }

    @ViewBuilder
    func background(for role: ButtonRole?) -> some View {
        if type != .quaternary {
            switch controlBorderShape {
            case .capsule:
                Capsule()
                    .fill(backgroundColor(for: role)
                        .opacity(backgroundOpacity))
                    .overlay {
                        Capsule()
                            .strokeBorder(Color.onSurfaceHighEmphasis.opacity(0.15), lineWidth: 2)
                            .opacity(isBordered || theme.borderButtons ? 1 : 0)
                    }

            case let .roundedRectangle(radius):
                RoundedRectangle(cornerRadius: radius != .medium ? radius.rawValue : theme.radius, style: .continuous)
                    .fill(backgroundColor(for: role)
                        .opacity(backgroundOpacity))
                    .overlay {
                        RoundedRectangle(cornerRadius: radius != .medium ? radius.rawValue : theme.radius, style: .continuous)
                            .strokeBorder(Color.onSurfaceHighEmphasis.opacity(0.15), lineWidth: 2)
                            .opacity(isBordered || theme.borderButtons ? 1 : 0)
                    }
            }
        }
    }

    /// Parameters
    func backgroundColor(for role: ButtonRole?) -> Color {
        switch type {
        case .primary:
            switch role {
            case .some(.destructive): return Color.error
            case .some(.cancel): return Color.accent
            default:
                if isAccent {
                    return Color.accent
                } else {
                    return Color.primary
                }
            }
        case .secondary:
            return Color.surfacePrimary
        case .tertiary:
            return Color.surfaceSecondary
        case .quaternary:
            return Color.clear
        }
    }

    func foregroundColor(for role: ButtonRole?) -> Color {
        switch type {
        case .primary:
            return Color.onPrimaryHighEmphasis
        case .secondary, .quaternary:
            switch role {
            case .some(.destructive): return Color.error
            case .some(.cancel): return Color.accent
            default:
                if isAccent {
                    return Color.accent
                } else {
                    return Color.onSurfaceHighEmphasis
                }
            }
        case .tertiary:
            switch role {
            case .some(.destructive): return Color.error
            case .some(.cancel): return Color.onSurfaceHighEmphasis
            default:
                if isAccent {
                    return Color.accent
                } else {
                    return Color.onSurfaceHighEmphasis
                }
            }
        }
    }

    @ViewBuilder
    func loadingView(for role: ButtonRole?) -> some View {
        if isLoading {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: foregroundColor(for: role)))
        } else {
            EmptyView()
        }
    }

    var horizontalPadding: Space {
        switch controlSize {
        case .mini:
            return .xxSmall
        case .small:
            return .small
        case .regular:
            return .small
        case .large:
            return .medium
        @unknown default:
            return .zero
        }
    }

    var verticalPadding: Space {
        switch controlSize {
        case .mini:
            return .xxSmall
        case .small:
            return .xxSmall
        case .regular:
            return .small
        case .large:
            return .medium
        @unknown default:
            return .zero
        }
    }

    var backgroundOpacity: CGFloat {
        isEnabled ? 1 : 0.5
    }

    var foregroundOpacity: CGFloat {
        isEnabled ? 1 : 0.7
    }

    private var maxWidth: CGFloat? {
        if isInfinityWidth == nil, controlSize == .regular {
            return .infinity
        } else if let infinity = isInfinityWidth, infinity == true {
            return .infinity
        } else {
            return nil
        }
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
