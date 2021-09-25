//
// Copyright © 2021 Alexander Romanov
// Created on 11.09.2021
//

import SwiftUI

public enum BarButtonType {
    case close
    case closeAction(action: () -> Void)
    case back
    case backAction(action: () -> Void)
    case accent(_ text: String, action: () -> Void)
    case primary(_ text: String, action: () -> Void)
    case secondary(_ text: String, action: () -> Void)
    case disabled(_ text: String)
}

public struct BarButton: View {
    @Environment(\.presentationMode) var presentationMode

    private var type: BarButtonType

    public init(type: BarButtonType) {
        self.type = type
    }

    public var body: some View {
        buttonView()
    }
}

// swiftlint:disable multiple_closures_with_trailing_closure
extension BarButton {
    @ViewBuilder
    private func buttonView() -> some View {
        switch type {
        case .close:

            Button(action: { presentationMode.wrappedValue.dismiss() }) {
                Icon(.xMini)
            }
            .style(.secondary, size: .medium, rounded: .full, width: .round, shadow: true)

        case .back:

            Button(action: { presentationMode.wrappedValue.dismiss() }) {
                Icon(.arrowLeft)
            }
            .style(.secondary, size: .medium, rounded: .full, width: .round, shadow: true)

        case let .secondary(text, action: action):

            Button(action: action) {
                Text(text)
            }
            .style(.secondary, size: .medium, rounded: .full, shadow: true)

        case let .accent(text, action: action):

            Button(action: action) {
                Text(text)
            }
            .style(.accent, size: .medium, rounded: .full, shadow: true)

        case let .primary(text, action: action):

            Button(action: action) {
                Text(text)
            }
            .style(.primary, size: .medium, rounded: .full, shadow: true)

        case let .closeAction(action: action):

            Button(action: action) {
                Icon(.xMini)
            }
            .style(.secondary, size: .medium, rounded: .full, width: .round, shadow: true)

        case let .backAction(action: action):

            Button(action: action) {
                Icon(.arrowLeft)
            }
            .style(.secondary, size: .medium, rounded: .full, width: .round, shadow: true)

        case let .disabled(text):

            Button(action: {}) {
                Text(text)
            }
            .style(.gray, size: .medium, rounded: .full, shadow: false)
            .disabled(true)
        }
    }
}
