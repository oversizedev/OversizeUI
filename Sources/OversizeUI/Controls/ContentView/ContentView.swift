//
// Copyright © 2021 Alexander Romanov
// ContentView.swift, created on 02.04.2022
//

import SwiftUI

public enum ContenButtonType {
    case close
    case closeAction(action: () -> Void)
    case back
    case backAction(action: () -> Void)
    case accent(_ text: String, action: () -> Void)
    case primary(_ text: String, action: () -> Void)
    case secondary(_ text: String, action: () -> Void)
    case disabled(_ text: String)
}

public struct ContentView: View {
    @Environment(\.multilineTextAlignment) var multilineTextAlignment
    @Environment(\.dismiss) var dismiss

    private let image: Image?
    private let title: String
    private let subtitle: String?

    private let primaryButton: ContenButtonType?
    private let secondaryButton: ContenButtonType?

    public init(image: Image? = nil,
                title: String,
                subtitle: String? = nil,
                primaryButton: ContenButtonType? = nil,
                secondaryButton: ContenButtonType? = nil)
    {
        self.image = image
        self.title = title
        self.subtitle = subtitle

        self.primaryButton = primaryButton
        self.secondaryButton = secondaryButton
    }

    public var body: some View {
        VStack(alignment: vStackAlignment, spacing: .large) {
            if let image {
                image
                    .frame(width: 218, height: 218, alignment: .bottom)
            }

            TextBox(title: title, subtitle: subtitle)

            primaryButtonView()

            secondaryButtonView()
        }
    }

    var vStackAlignment: HorizontalAlignment {
        switch multilineTextAlignment {
        case .leading:
            return .leading
        case .center:
            return .center
        case .trailing:
            return .trailing
        }
    }
}

// swiftlint:disable multiple_closures_with_trailing_closure
extension ContentView {
    @ViewBuilder
    private func primaryButtonView() -> some View {
        switch primaryButton {
        case .close:

            Button(action: { dismiss() }) {
                Icon(.xMini)
            }
            .buttonStyle(.secondary)

        case .back:

            Button(action: { dismiss() }) {
                Icon(.arrowLeft)
            }
            .buttonStyle(.secondary)

        case let .secondary(text, action: action):

            Button(action: action) {
                Text(text)
            }
            .buttonStyle(.secondary)

        case let .accent(text, action: action):

            Button(action: action) {
                Text(text)
            }
            .buttonStyle(.primary)
            .accent()

        case let .primary(text, action: action):

            Button(action: action) {
                Text(text)
            }
            .buttonStyle(.primary)

        case let .closeAction(action: action):

            Button(action: action) {
                Icon(.xMini)
            }
            .buttonStyle(.secondary)

        case let .backAction(action: action):

            Button(action: action) {
                Icon(.arrowLeft)
            }
            .buttonStyle(.secondary)

        case let .disabled(text):

            Button(action: {}) {
                Text(text)
            }
            .buttonStyle(.quaternary)
            .disabled(true)

        case .none:
            EmptyView()
        }
    }

    @ViewBuilder
    private func secondaryButtonView() -> some View {
        switch secondaryButton {
        case .close:

            Button(action: { dismiss() }) {
                Icon(.xMini)
            }
            .buttonStyle(.secondary)

        case .back:

            Button(action: { dismiss() }) {
                Icon(.arrowLeft)
            }
            .buttonStyle(.secondary)

        case let .secondary(text, action: action):

            Button(action: action) {
                Text(text)
            }
            .buttonStyle(.secondary)

        case let .accent(text, action: action):

            Button(action: action) {
                Text(text)
            }
            .buttonStyle(.primary)
            .accent()

        case let .primary(text, action: action):

            Button(action: action) {
                Text(text)
            }
            .buttonStyle(.primary)
            .accent()

        case let .closeAction(action: action):

            Button(action: action) {
                Icon(.xMini)
            }
            .buttonStyle(.secondary)

        case let .backAction(action: action):

            Button(action: action) {
                Icon(.arrowLeft)
            }
            .buttonStyle(.secondary)

        case let .disabled(text):

            Button(action: {}) {
                Text(text)
            }
            .buttonStyle(.tertiary)
            .disabled(true)

        case .none:
            EmptyView()
        }
    }
}
