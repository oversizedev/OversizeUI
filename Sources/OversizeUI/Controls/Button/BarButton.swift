//
// Copyright © 2021 Alexander Romanov
// BarButton.swift, created on 10.04.2021
//

import SwiftUI

public enum BarButtonType {
    case close
    case closeAction(_ action: () -> Void)
    case back
    case backAction(_ action: () -> Void)
    case accent(_ text: String, action: () -> Void)
    case primary(_ text: String, action: () -> Void)
    case secondary(_ text: String, action: () -> Void)
    @available(*, deprecated, message: "Use .disabled() modificator")
    case disabled(_ text: String)
    case image(_ image: Image, action: () -> Void)
    @available(*, renamed: "image")
    case icon(_ icon: IconsNames, action: () -> Void)
}

public struct BarButton: View {
    @Environment(\.dismiss) var dismiss

    private var type: BarButtonType

    public init(_ type: BarButtonType) {
        self.type = type
    }

    @available(*, deprecated, message: "Delete type prefix from init")
    public init(type: BarButtonType) {
        self.type = type
    }

    public var body: some View {
        #if os(tvOS)
        Button(action: buttonAction) {
            label
        }
        .buttonStyle(buttonStyle)
        .controlBorderShape(.capsule)
        .accent(isAccent)
        .disabled(isDisabled)
        .elevation(isDisabled ? .z0 : .z2)
        #else
        Group {
            if isIconButtonStyle {
                Button(action: buttonAction) {
                    label
                }
                .buttonStyle(iconButtonStyle)
            } else {
                Button(action: buttonAction) {
                    label
                }
                .buttonStyle(buttonStyle)
            }
        }
        .controlBorderShape(.capsule)
        .controlSize(.small)
        .accent(isAccent)
        .disabled(isDisabled)
        .elevation(.z2)
        #endif
    }

    private var isAccent: Bool {
        switch type {
        case .accent:
            true
        default:
            false
        }
    }

    private var isDisabled: Bool {
        switch type {
        case .disabled:
            true
        default:
            false
        }
    }

    private var buttonStyle: OversizeButtonStyle {
        switch type {
        case .close, .closeAction, .back, .backAction, .image, .icon, .secondary:
            .secondary
        case .accent, .primary:
            .primary
        case .disabled:
            .tertiary
        }
    }

    private var iconButtonStyle: IconButtonStyle {
        switch type {
        case .close, .closeAction, .back, .backAction, .image, .icon, .secondary:
            .iconSecondary
        case .accent, .primary:
            .iconPrimary
        case .disabled:
            .iconTertiary
        }
    }

    private var isIconButtonStyle: Bool {
        switch type {
        case .close, .closeAction, .back, .backAction, .image, .icon:
            true
        default:
            false
        }
    }

    private var buttonAction: () -> Void {
        switch type {
        case .back, .close:
            { dismiss() }
        case let .closeAction(action: action):
            action
        case let .backAction(action: action):
            action
        case let .accent(_, action: action):
            action
        case let .primary(_, action: action):
            action
        case let .secondary(_, action: action):
            action
        case .disabled:
            {}
        case let .image(_, action: action):
            action
        case let .icon(_, action: action):
            action
        }
    }

    @ViewBuilder
    private var label: some View {
        switch type {
        case .close:
            IconDeprecated(.xMini)
        case .back:
            IconDeprecated(.arrowLeft)
        case let .secondary(text, _):
            Text(text)
        case let .accent(text, _):
            Text(text)
        case let .primary(text, _):
            Text(text)
        case .closeAction:
            IconDeprecated(.xMini, color: .onSurfaceSecondary)
        case .backAction:
            IconDeprecated(.arrowLeft, color: .onSurfaceSecondary)
        case let .disabled(text):
            Text(text)
        case let .image(image, _):
            image
                .renderingMode(.template)
                .onSurfacePrimaryForeground()
        case let .icon(icon, _):
            IconDeprecated(icon, color: .onSurfaceSecondary)
        }
    }
}
