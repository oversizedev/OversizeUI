//
// Copyright © 2025 Alexander Romanov
// ButtonType.swift, created on 18.05.2025
//

import SwiftUI

public struct IconButtonStyle: ButtonStyle {
    @Environment(\.theme) private var theme: ThemeSettings
    @Environment(\.isEnabled) private var isEnabled: Bool
    @Environment(\.isLoading) private var isLoading: Bool
    @Environment(\.isAccent) private var isAccent: Bool
    @Environment(\.elevation) private var elevation: Elevation
    @Environment(\.isBordered) var isBordered: Bool
    #if !os(tvOS)
    @Environment(\.controlSize) var controlSize: ControlSize
    #endif

    private let type: ButtonType

    public init(_ type: ButtonType) {
        self.type = type
    }

    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .body(.semibold)
            .opacity(isLoading ? 0 : 1)
            .foregroundColor(foregroundColor(for: configuration.role).opacity(foregroundOpacity))
            .padding(padding)
            .background(background(for: configuration.role))
            .overlay(loadingView(for: configuration.role))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .shadowElevation(isEnabled ? elevation : .z0)
    }

    @ViewBuilder
    private func background(for role: ButtonRole?) -> some View {
        if type != .quaternary {
            Circle()
                .fill(backgroundColor(for: role)
                    .opacity(backgroundOpacity))
                .overlay {
                    Capsule()
                        .strokeBorder(Color.onSurfacePrimary.opacity(0.15), lineWidth: 2)
                        .opacity(isBordered || theme.borderButtons ? 1 : 0)
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

    private var padding: Space {
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
}

public extension ButtonStyle where Self == IconButtonStyle {
    static var iconPrimary: IconButtonStyle {
        IconButtonStyle(.primary)
    }

    static var iconSecondary: IconButtonStyle {
        IconButtonStyle(.secondary)
    }

    static var iconTertiary: IconButtonStyle {
        IconButtonStyle(.tertiary)
    }

    static var iconQuaternary: IconButtonStyle {
        IconButtonStyle(.quaternary)
    }
}

@available(tvOS, unavailable)
struct IcobButtonStyle_Previews: PreviewProvider {
    struct Buttons: View {
        var body: some View {
            Group {
                Button(role: .cancel) {} label: {
                    Image.Base.arrowLeft.templated
                }
                .buttonStyle(.iconPrimary)

                Button(role: .destructive) {} label: {
                    Image.Base.arrowLeft.templated
                }
                .buttonStyle(.iconPrimary)

                Button {} label: {
                    Image.Base.arrowLeft.templated
                }
                .buttonStyle(.iconPrimary)

                Button(role: .cancel) {} label: {
                    Image.Base.arrowLeft.templated
                }
                .buttonStyle(IconButtonStyle(.secondary))

                Button(role: .destructive) {} label: {
                    Image.Base.arrowLeft.templated
                }
                .buttonStyle(IconButtonStyle(.secondary))

                Button {} label: {
                    Image.Base.arrowLeft.templated
                }
                .buttonStyle(IconButtonStyle(.secondary))
            }
            Group {
                Button(role: .cancel) {} label: {
                    Image.Base.arrowLeft.templated
                }
                .buttonStyle(IconButtonStyle(.tertiary))

                Button(role: .destructive) {} label: {
                    Image.Base.arrowLeft.templated
                }
                .buttonStyle(IconButtonStyle(.tertiary))

                Button {} label: {
                    Image.Base.arrowLeft.templated
                }
                .buttonStyle(IconButtonStyle(.tertiary))

                Button(role: .cancel) {} label: {
                    Image.Base.arrowLeft.templated
                }
                .buttonStyle(IconButtonStyle(.quaternary))

                Button(role: .destructive) {} label: {
                    Image.Base.arrowLeft.templated
                }
                .buttonStyle(IconButtonStyle(.quaternary))

                Button {} label: {
                    Image.Base.arrowLeft.templated
                }

                .buttonStyle(IconButtonStyle(.quaternary))
            }
        }
    }

    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Regular")
                    .title()

                Button(role: .cancel) {} label: {
                    Image.Base.arrowLeft.templated
                }
                .buttonStyle(IconButtonStyle(.primary))

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
