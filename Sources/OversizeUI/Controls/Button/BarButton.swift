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
        Button(action: buttonAction) {
            label
        }
        .buttonStyle(buttonStyle)
        .controlBorderShape(.capsule)
        .controlSize(controlSize)
        .accent(isAccent)
        .disabled(isDisabled)
        .elevation(.z2)
        #endif
    }

    @available(tvOS, unavailable)
    private var controlSize: ControlSize {
        switch type {
        case .close, .closeAction, .back, .backAction, .image, .icon:
            return .mini
        default:
            return .small
        }
    }

    private var isAccent: Bool {
        switch type {
        case .accent:
            return true
        default:
            return false
        }
    }

    private var isDisabled: Bool {
        switch type {
        case .disabled:
            return true
        default:
            return false
        }
    }

    private var buttonStyle: OversizeButtonStyle {
        switch type {
        case .close, .closeAction, .back, .backAction, .image, .icon, .secondary:
            return .secondary
        case .accent, .primary:
            return .primary
        case .disabled:
            return .tertiary
        }
    }

    private var buttonAction: () -> Void {
        switch type {
        case .back, .close:
            return { dismiss() }
        case let .closeAction(action: action):
            return action
        case let .backAction(action: action):
            return action
        case let .accent(_, action: action):
            return action
        case let .primary(_, action: action):
            return action
        case let .secondary(_, action: action):
            return action
        case .disabled:
            return {}
        case let .image(_, action: action):
            return action
        case let .icon(_, action: action):
            return action
        }
    }

    @ViewBuilder
    private var label: some View {
        switch type {
        case .close:
            Icon(.xMini)
        case .back:
            Icon(.arrowLeft)
        case let .secondary(text, _):
            Text(text)
        case let .accent(text, _):
            Text(text)
        case let .primary(text, _):
            Text(text)
        case .closeAction:
            Icon(.xMini, color: .onSurfaceMediumEmphasis)
        case .backAction:
            Icon(.arrowLeft, color: .onSurfaceMediumEmphasis)
        case let .disabled(text):
            Text(text)
        case let .image(image, _):
            image
                .renderingMode(.template)
                .onSurfaceHighEmphasisForegroundColor()
        case let .icon(icon, _):
            Icon(icon, color: .onSurfaceMediumEmphasis)
        }
    }
}
