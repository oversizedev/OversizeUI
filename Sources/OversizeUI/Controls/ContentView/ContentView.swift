//
// Copyright © 2022 Alexander Romanov
// ContentView.swift
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
    @Environment(\.presentationMode) var presentationMode

    private let image: Image?
    private let title: String
    private let subtitle: String?

    private let primaryButton: ContenButtonType?
    private let secondaryButton: ContenButtonType?

    public init(image: Image?,
                title: String,
                subtitle: String?,
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
        VStack(alignment: vStackAlignment, spacing: .medium) {
            if let image = image {
                image
                    .frame(width: 218, height: 218, alignment: .center)
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

            Button(action: { presentationMode.wrappedValue.dismiss() }) {
                Icon(.xMini)
            }
            .style(.secondary)

        case .back:

            Button(action: { presentationMode.wrappedValue.dismiss() }) {
                Icon(.arrowLeft)
            }
            .style(.secondary)

        case let .secondary(text, action: action):

            Button(action: action) {
                Text(text)
            }
            .style(.secondary)

        case let .accent(text, action: action):

            Button(action: action) {
                Text(text)
            }
            .style(.accent)

        case let .primary(text, action: action):

            Button(action: action) {
                Text(text)
            }
            .style(.primary)

        case let .closeAction(action: action):

            Button(action: action) {
                Icon(.xMini)
            }
            .style(.secondary)

        case let .backAction(action: action):

            Button(action: action) {
                Icon(.arrowLeft)
            }
            .style(.secondary)

        case let .disabled(text):

            Button(action: {}) {
                Text(text)
            }
            .style(.gray)
            .disabled(true)

        case .none:
            EmptyView()
        }
    }

    @ViewBuilder
    private func secondaryButtonView() -> some View {
        switch secondaryButton {
        case .close:

            Button(action: { presentationMode.wrappedValue.dismiss() }) {
                Icon(.xMini)
            }
            .style(.secondary)

        case .back:

            Button(action: { presentationMode.wrappedValue.dismiss() }) {
                Icon(.arrowLeft)
            }
            .style(.secondary)

        case let .secondary(text, action: action):

            Button(action: action) {
                Text(text)
            }
            .style(.secondary)

        case let .accent(text, action: action):

            Button(action: action) {
                Text(text)
            }
            .style(.accent)

        case let .primary(text, action: action):

            Button(action: action) {
                Text(text)
            }
            .style(.primary)

        case let .closeAction(action: action):

            Button(action: action) {
                Icon(.xMini)
            }
            .style(.secondary)

        case let .backAction(action: action):

            Button(action: action) {
                Icon(.arrowLeft)
            }
            .style(.secondary)

        case let .disabled(text):

            Button(action: {}) {
                Text(text)
            }
            .style(.gray)
            .disabled(true)

        case .none:
            EmptyView()
        }
    }
}
