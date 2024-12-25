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

    public init(
        image: Image? = nil,
        title: String,
        subtitle: String? = nil,
        primaryButton: ContenButtonType? = nil,
        secondaryButton: ContenButtonType? = nil
    ) {
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
                    .resizable()
                    .frame(width: 128, height: 128, alignment: .bottom)
            }

            TextBox(
                title: title,
                subtitle: subtitle,
                spacing: .xxSmall
            )

            primaryButtonView()

            secondaryButtonView()
        }
    }

    var vStackAlignment: HorizontalAlignment {
        switch multilineTextAlignment {
        case .leading:
            .leading
        case .center:
            .center
        case .trailing:
            .trailing
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
                IconDeprecated(.xMini)
            }
            #if os(iOS)
            .buttonStyle(.secondary)
            #endif
            #if os(macOS)
            .controlSize(.large)
            #endif
        case .back:

            Button(action: { dismiss() }) {
                IconDeprecated(.arrowLeft)
            }
            #if os(iOS)
            .buttonStyle(.secondary)
            #endif
            #if os(macOS)
            .controlSize(.large)
            #endif
        case let .secondary(text, action: action):

            Button(action: action) {
                Text(text)
            }
            #if os(iOS)
            .buttonStyle(.secondary)
            #endif
            #if os(macOS)
            .controlSize(.large)
            #endif
        case let .accent(text, action: action):

            Button(action: action) {
                Text(text)
            }
            #if os(iOS)
            .buttonStyle(.primary)
            .accent()
            #endif
            #if os(macOS)
            .controlSize(.large)
            .buttonStyle(.borderedProminent)
            .keyboardShortcut(.defaultAction)
            #endif
        case let .primary(text, action: action):

            Button(action: action) {
                Text(text)
            }
            #if os(iOS)
            .buttonStyle(.primary)
            #endif
            #if os(macOS)
            .controlSize(.large)
            .buttonStyle(.borderedProminent)
            .keyboardShortcut(.defaultAction)
            #endif
        case let .closeAction(action: action):

            Button(action: action) {
                IconDeprecated(.xMini)
            }
            #if os(iOS)
            .buttonStyle(.secondary)
            #endif
            #if os(macOS)
            .controlSize(.large)
            #endif
        case let .backAction(action: action):

            Button(action: action) {
                IconDeprecated(.arrowLeft)
            }
            #if os(iOS)
            .buttonStyle(.secondary)
            #endif
            #if os(macOS)
            .controlSize(.large)
            #endif
        case let .disabled(text):

            Button(action: {}) {
                Text(text)
            }
            #if os(iOS)
            .buttonStyle(.quaternary)
            .disabled(true)
            #endif
            #if os(macOS)
            .controlSize(.large)
            #endif
        case .none:
            EmptyView()
        }
    }

    @ViewBuilder
    private func secondaryButtonView() -> some View {
        switch secondaryButton {
        case .close:

            Button(action: { dismiss() }) {
                IconDeprecated(.xMini)
            }
            #if os(iOS)
            .buttonStyle(.secondary)
            #endif
        case .back:

            Button(action: { dismiss() }) {
                IconDeprecated(.arrowLeft)
            }
            #if os(iOS)
            .buttonStyle(.secondary)
            #endif
        case let .secondary(text, action: action):

            Button(action: action) {
                Text(text)
            }
            #if os(iOS)
            .buttonStyle(.secondary)
            #endif
        case let .accent(text, action: action):

            Button(action: action) {
                Text(text)
            }
            #if os(iOS)
            .buttonStyle(.primary)
            .accent()
            #endif
        case let .primary(text, action: action):

            Button(action: action) {
                Text(text)
            }
            #if os(iOS)
            .buttonStyle(.primary)
            .accent()
            #endif
        case let .closeAction(action: action):

            Button(action: action) {
                IconDeprecated(.xMini)
            }
            #if os(iOS)
            .buttonStyle(.secondary)
            #endif
        case let .backAction(action: action):

            Button(action: action) {
                IconDeprecated(.arrowLeft)
            }
            #if os(iOS)
            .buttonStyle(.secondary)
            #endif
        case let .disabled(text):

            Button(action: {}) {
                Text(text)
            }
            #if os(iOS)
            .buttonStyle(.tertiary)
            #endif
            .disabled(true)
        case .none:
            EmptyView()
        }
    }
}
