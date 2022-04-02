//
// Copyright © 2022 Alexander Romanov
// ContentView.swift
//

import SwiftUI

public struct ContentView: View {
    @Environment(\.multilineTextAlignment) var multilineTextAlignment

    private let image: Image?
    private let title: String
    private let subtitle: String?

    private let primaryButtonLabel: String?
    private let secondaryButtonLabel: String?

    private let primaryAction: (() -> Void)?
    private let secondaryAction: (() -> Void)?

    public init(image: Image?,
                title: String,
                subtitle: String?,
                primaryButtonLabel: String? = nil,
                secondaryButtonLabel: String? = nil,
                primaryAction: (() -> Void)? = nil,
                secondaryAction: (() -> Void)? = nil)
    {
        self.image = image
        self.title = title
        self.subtitle = subtitle

        self.primaryButtonLabel = primaryButtonLabel
        self.secondaryButtonLabel = secondaryButtonLabel

        self.primaryAction = primaryAction
        self.secondaryAction = secondaryAction
    }

    public init(image: Image?,
                title: String,
                subtitle: String?,
                primaryButtonLabel: String? = nil,
                primaryAction: (() -> Void)? = nil)
    {
        self.image = image
        self.title = title
        self.subtitle = subtitle

        self.primaryButtonLabel = primaryButtonLabel
        secondaryButtonLabel = nil

        self.primaryAction = primaryAction
        secondaryAction = nil
    }

    public var body: some View {
        VStack(alignment: vStackAlignment, spacing: .medium) {
            if let image = image {
                image
                    .frame(width: 218, height: 218, alignment: .center)
            }

            TextBox(title: title, subtitle: subtitle)

            if let primaryButtonLabel = primaryButtonLabel, let primaryAction = primaryAction {
                Button(action: primaryAction) {
                    Text(primaryButtonLabel)
                }
                .buttonStyle(.accent)
            }

            if let secondaryButtonLabel = secondaryButtonLabel, let secondaryAction = secondaryAction {
                Button(action: secondaryAction) {
                    Text(secondaryButtonLabel)
                }
                .buttonStyle(.text)
            }
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
