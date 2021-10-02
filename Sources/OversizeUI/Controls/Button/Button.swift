//
// Copyright © 2021 Alexander Romanov
// Created on 02.10.2021
//

import SwiftUI

public enum ButtonType: Int, CaseIterable {
    case accent
    case primary
    case secondary
    case gray
    case text
    case link
    case deleteLink
}

public enum ButtonSize {
    case large
    case medium
}

public enum ButtonRounded {
    case full
    case medium
    case small
    case none
}

public enum ButtonWidth {
    case full
    case round
    case standart
}

// swiftlint:disable line_length type_body_length
public struct ButtonStyleExtended: ButtonStyle {
    @ObservedObject var appearanceSettings = AppearanceSettings.shared

    var style: ButtonType
    var size: ButtonSize = .large
    var rounded: ButtonRounded = .medium
    var width: ButtonWidth = .full
    var shadow: Bool = true

    private enum Constants {
        /// Size
        static var heightL: CGFloat { Space.xLarge.rawValue + Space.xxSmall.rawValue }
        static var heightM: CGFloat { Space.large.rawValue + Space.xxSmall.rawValue }

        /// Radius
        static var radiusM: CGFloat { Radius.medium.rawValue }
        static var radiusS: CGFloat { Radius.small.rawValue }
    }

    @ViewBuilder
    public func makeBody(configuration: ButtonStyle.Configuration) -> some View {
        switch style {
        case .primary:
            PrimaryButton(size: size, rounded: rounded, width: width, shadow: shadow, isBordered: appearanceSettings.borderButtons, borderLineWidth: CGFloat(appearanceSettings.borderSize), configuration: configuration)
        case .secondary:
            SecondaryButton(size: size, rounded: rounded, width: width, shadow: shadow, isBordered: appearanceSettings.borderButtons, borderLineWidth: CGFloat(appearanceSettings.borderSize), configuration: configuration)
        case .gray:
            GrayButton(size: size, rounded: rounded, width: width, shadow: shadow, isBordered: appearanceSettings.borderButtons, borderLineWidth: CGFloat(appearanceSettings.borderSize), configuration: configuration)
        case .text:
            TextButton(size: size, rounded: rounded, width: width, configuration: configuration)
        case .link:
            LinkButton(size: size, rounded: rounded, width: width, shadow: shadow, configuration: configuration)
        case .deleteLink:
            DeleteButton(size: size, rounded: rounded, width: width, shadow: shadow, configuration: configuration)
        case .accent:
            AccentButton(size: size, rounded: rounded, width: width, shadow: shadow, configuration: configuration, isBordered: appearanceSettings.borderButtons, borderLineWidth: CGFloat(appearanceSettings.borderSize))
        }
    }

    struct AccentButton: View {
        var size: ButtonSize
        var rounded: ButtonRounded
        var width: ButtonWidth
        var shadow: Bool
        let configuration: ButtonStyle.Configuration
        var isBordered: Bool
        var borderLineWidth: CGFloat
        @Environment(\.isEnabled) private var isEnabled: Bool
        var body: some View {
            configuration.label
                .fontStyle(.button)
                .padding(.horizontal, Space.small)
                .foregroundColor(isEnabled ? .onPrimaryHighEmphasis : .onPrimaryDisabled)
                .frame(maxWidth: width == .full ? .infinity : width == .standart ? nil : size == .large ? Constants.heightL : Constants.heightM,
                       minHeight: size == .large ? ButtonStyleExtended.Constants.heightL : ButtonStyleExtended.Constants.heightM)
                .background(
                    RoundedRectangle(cornerRadius: rounded == .none ? 0 : rounded == .medium ? ButtonStyleExtended.Constants.radiusM : rounded == .small ? ButtonStyleExtended.Constants.radiusS :
                        size == .large ? ButtonStyleExtended.Constants.heightL / 2 : ButtonStyleExtended.Constants.heightM / 2,
                        style: .continuous)
                        .fill(isEnabled ? Color.accent : Color.accent.opacity(0.9))
                        .overlay(
                            RoundedRectangle(cornerRadius: rounded == .none ? 0 : rounded == .medium ? ButtonStyleExtended.Constants.radiusM : rounded == .small ? ButtonStyleExtended.Constants.radiusS :
                                size == .large ? ButtonStyleExtended.Constants.heightL / 2 : ButtonStyleExtended.Constants.heightM / 2,
                                style: .continuous)
                                .stroke(isBordered
                                    ? Color.border
                                    : isEnabled ? Color.accent : Color.accent.opacity(0.9), lineWidth: 1)
                        )
                )
                .opacity(configuration.isPressed ? 0.9 : 1)
                .scaleEffect(configuration.isPressed ? 0.95 : 1)
                // .animation(.spring())
                .shadowElevaton(shadow ? .z2 : .z0, color: Color.accent)
        }
    }

    struct PrimaryButton: View {
        var size: ButtonSize
        var rounded: ButtonRounded
        var width: ButtonWidth
        var shadow: Bool
        var isBordered: Bool
        var borderLineWidth: CGFloat
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        var body: some View {
            configuration.label
                .fontStyle(.button)
                .padding(.horizontal, Space.small)
                .foregroundColor(isEnabled ? Color.backgroundPrimary : .onPrimaryDisabled)
                .frame(maxWidth: width == .full ? .infinity : width == .standart ? nil : size == .large ? Constants.heightL : Constants.heightM,
                       minHeight: size == .large ? ButtonStyleExtended.Constants.heightL : ButtonStyleExtended.Constants.heightM)
                .background(
                    RoundedRectangle(cornerRadius: rounded == .none ? 0 : rounded == .medium ? ButtonStyleExtended.Constants.radiusM : rounded == .small ? ButtonStyleExtended.Constants.radiusS :
                        size == .large ? ButtonStyleExtended.Constants.heightL / 2 : ButtonStyleExtended.Constants.heightM / 2,
                        style: .continuous)
                        .fill(isEnabled ? Color.primary : Color.primary.opacity(0.9))
                        .overlay(
                            RoundedRectangle(cornerRadius: rounded == .none ? 0 : rounded == .medium ? ButtonStyleExtended.Constants.radiusM : rounded == .small ? ButtonStyleExtended.Constants.radiusS :
                                size == .large ? ButtonStyleExtended.Constants.heightL / 2 : ButtonStyleExtended.Constants.heightM / 2,
                                style: .continuous)
                                .stroke(isBordered
                                    ? Color.border
                                    : isEnabled ? Color.primary : Color.primary.opacity(0.9), lineWidth: 1)
                        )
                )
                .opacity(configuration.isPressed ? 0.9 : 1)
                .scaleEffect(configuration.isPressed ? 0.95 : 1)
                // .animation(.spring())
                .shadowElevaton(shadow ? .z2 : .z0, color: Color.primary)
        }
    }

    struct SecondaryButton: View {
        var size: ButtonSize
        var rounded: ButtonRounded
        var width: ButtonWidth
        var shadow: Bool
        var isBordered: Bool
        var borderLineWidth: CGFloat
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        var body: some View {
            configuration.label
                .fontStyle(.button)
                .padding(.horizontal, Space.small)
                .foregroundColor(isEnabled ? .onSurfaceHighEmphasis : .onSurfaceDisabled)
                .frame(maxWidth: width == .full ? .infinity : width == .standart ? nil : size == .large ? Constants.heightL : Constants.heightM,
                       minHeight: size == .large ? ButtonStyleExtended.Constants.heightL : ButtonStyleExtended.Constants.heightM)
                .background(
                    RoundedRectangle(cornerRadius: rounded == .none ? 0 : rounded == .medium ? ButtonStyleExtended.Constants.radiusM : rounded == .small ? ButtonStyleExtended.Constants.radiusS :
                        size == .large ? ButtonStyleExtended.Constants.heightL / 2 : ButtonStyleExtended.Constants.heightM / 2,
                        style: .continuous)
                        .fill(isEnabled ? Color.surfacePrimary : Color.surfaceSecondary.opacity(0.9))
                        .overlay(
                            RoundedRectangle(cornerRadius: rounded == .none ? 0 : rounded == .medium ? ButtonStyleExtended.Constants.radiusM : rounded == .small ? ButtonStyleExtended.Constants.radiusS :
                                size == .large ? ButtonStyleExtended.Constants.heightL / 2 : ButtonStyleExtended.Constants.heightM / 2,
                                style: .continuous)
                                .stroke(isBordered
                                    ? Color.border
                                    : isEnabled ? Color.surfacePrimary : Color.surfaceSecondary.opacity(0.9), lineWidth: 1)
                        )
                )
                .opacity(configuration.isPressed ? 0.9 : 1)
                .scaleEffect(configuration.isPressed ? 0.95 : 1)
                // .animation(.spring())
                .shadowElevaton(shadow ? .z2 : .z0)
        }
    }

    struct GrayButton: View {
        var size: ButtonSize
        var rounded: ButtonRounded
        var width: ButtonWidth
        var shadow: Bool
        var isBordered: Bool
        var borderLineWidth: CGFloat
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        var body: some View {
            configuration.label
                .fontStyle(.button)
                .padding(.horizontal, Space.small)
                .foregroundColor(isEnabled ? .onBackgroundHighEmphasis : .onBackgroundDisabled)
                .frame(maxWidth: width == .full ? .infinity : width == .standart ? nil : size == .large ? Constants.heightL : Constants.heightM,
                       minHeight: size == .large ? ButtonStyleExtended.Constants.heightL : ButtonStyleExtended.Constants.heightM)
                .background(
                    RoundedRectangle(cornerRadius: rounded == .none ? 0 : rounded == .medium ? ButtonStyleExtended.Constants.radiusM : rounded == .small ? ButtonStyleExtended.Constants.radiusS :
                        size == .large ? ButtonStyleExtended.Constants.heightL / 2 : ButtonStyleExtended.Constants.heightM / 2,
                        style: .continuous)
                        .fill(isEnabled ? Color.backgroundSecondary : Color.backgroundSecondary.opacity(0.9))
                        .overlay(
                            RoundedRectangle(cornerRadius: rounded == .none ? 0 : rounded == .medium ? ButtonStyleExtended.Constants.radiusM : rounded == .small ? ButtonStyleExtended.Constants.radiusS :
                                size == .large ? ButtonStyleExtended.Constants.heightL / 2 : ButtonStyleExtended.Constants.heightM / 2,
                                style: .continuous)
                                .stroke(isBordered
                                    ? Color.border
                                    : isEnabled ? Color.backgroundSecondary : Color.backgroundSecondary.opacity(0.9), lineWidth: 1)
                        )
                )
                .opacity(configuration.isPressed ? 0.9 : 1)
                .scaleEffect(configuration.isPressed ? 0.95 : 1)
                // .animation(.spring())
                .shadowElevaton(shadow ? .z2 : .z0)
        }
    }

    struct TextButton: View {
        var size: ButtonSize
        var rounded: ButtonRounded
        var width: ButtonWidth
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        var body: some View {
            configuration.label
                .fontStyle(.button)
                .padding(.horizontal, Space.small)
                .foregroundColor(isEnabled ? .onSurfaceHighEmphasis : .onSurfaceDisabled)
                .frame(maxWidth: width == .full ? .infinity : width == .standart ? nil : size == .large ? Constants.heightL : Constants.heightM,
                       minHeight: size == .large ? ButtonStyleExtended.Constants.heightL : ButtonStyleExtended.Constants.heightM)
                .opacity(configuration.isPressed ? 0.9 : 1)
                .scaleEffect(configuration.isPressed ? 0.95 : 1)
            // .animation(.spring())
        }
    }

    struct LinkButton: View {
        var size: ButtonSize
        var rounded: ButtonRounded
        var width: ButtonWidth
        var shadow: Bool
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        var body: some View {
            configuration.label
                .fontStyle(.button)
                .padding(.horizontal, Space.small)
                .foregroundColor(isEnabled ? .accent : Color.accent.opacity(0.7))
                .frame(maxWidth: width == .full ? .infinity : width == .standart ? nil : size == .large ? Constants.heightL : Constants.heightM,
                       minHeight: size == .large ? ButtonStyleExtended.Constants.heightL : ButtonStyleExtended.Constants.heightM)
                .opacity(configuration.isPressed ? 0.9 : 1)
                .scaleEffect(configuration.isPressed ? 0.95 : 1)
            // .animation(.spring())
        }
    }

    struct DeleteButton: View {
        var size: ButtonSize
        var rounded: ButtonRounded
        var width: ButtonWidth
        var shadow: Bool
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        var body: some View {
            configuration.label
                .fontStyle(.button)
                .padding(.horizontal, Space.small)
                .foregroundColor(isEnabled ? .error : Color.error.opacity(0.7))
                .frame(maxWidth: width == .full ? .infinity : width == .standart ? nil : size == .large ? Constants.heightL : Constants.heightM,
                       minHeight: size == .large ? ButtonStyleExtended.Constants.heightL : ButtonStyleExtended.Constants.heightM)
                .opacity(configuration.isPressed ? 0.9 : 1)
                .scaleEffect(configuration.isPressed ? 0.95 : 1)
            // .animation(.spring())
        }
    }
}

// public struct ButtonLoadingStyle: ButtonStyle {
//    var loading: Bool = false
//
//    public func makeBody(configuration: ButtonStyle.Configuration) -> some View {
//        if loading {
//            return configuration
//        } else {
//            return configuration
//        }
//
//    }
//
//
// }

public extension Button {
    /// Changes the appearance of the button

    func style(_ style: ButtonType) -> some View {
        buttonStyle(ButtonStyleExtended(style: style))
    }

    func style(_ style: ButtonType, size: ButtonSize) -> some View {
        buttonStyle(ButtonStyleExtended(style: style, size: size))
    }

    func style(_ style: ButtonType, size: ButtonSize, shadow: Bool) -> some View {
        buttonStyle(ButtonStyleExtended(style: style, size: size, shadow: shadow))
    }

    func style(_ style: ButtonType, size: ButtonSize, rounded: ButtonRounded, width: ButtonWidth = .standart, shadow: Bool) -> some View {
        buttonStyle(ButtonStyleExtended(style: style, size: size, rounded: rounded, width: width, shadow: shadow))
    }
    //
    //    public func style(_ style: ButtonType, size: ButtonSize, rounded: ButtonRounded, width: ButtonWidth, shadow: Bool, isLoading: Binding<Bool>) -> some View {
    //        self.buttonStyle(ButtonStyleExtended(style: style, size: size, rounded: rounded, width: width, shadow: shadow, isLoading: isLoading))
    //    }
}

//
// extension Button {
//    public func isLoad(_ loding: Bool) -> some View {
//        self.overlay(
//            AboutView()
//        )
//    }
// }

struct ButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 16) {
            Button("Button") { print(#function) }
                .style(.primary)

            Button("Button") { print(#function) }
                .style(.primary)

            Button("Button") { print(#function) }
                .style(.secondary)

            Button("Button") { print(#function) }
                .style(.gray)

            Button("Button") { print(#function) }
                .style(.text)

            Button("Button") { print(#function) }
                .style(.link)

            Button("Button") { print(#function) }
                .style(.deleteLink)

            Button("Button") { print(#function) }
                .style(.secondary, size: .medium, rounded: .full, width: .full, shadow: true)

        }.padding()
    }
}
