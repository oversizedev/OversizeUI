//
// Copyright © 2024 Alexander Romanov
// BlankView.swift, created on 15.11.2024
//

import SwiftUI

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
public struct EmptyStateView<Actions>: View where Actions: View {
    private let image: Image?
    private let title: String
    private let subtitle: String?
    @ViewBuilder private let actions: Actions

    public init(
        image: Image? = nil,
        title: String,
        subtitle: String? = nil,
        @ContentViewActionsBuilder actions: () -> Actions = { EmptyView() }
    ) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
        self.actions = actions()
    }

    public var body: some View {
        #if os(macOS)
        macOSContentView
        #else
        contenView
        #endif
    }

    private var contenView: some View {
        VStack(alignment: .center, spacing: .large) {
            if let image {
                image
                    .frame(width: 128, height: 128, alignment: .bottom)
            }

            TextBox(
                title: title,
                subtitle: subtitle,
                spacing: .xxSmall
            )
            .multilineTextAlignment(.center)

            actions
            #if !os(tvOS)
            .controlSize(.large)
            #endif
        }
        .paddingContent()
        .containerRelativeFrame([.horizontal, .vertical])
    }

    private var macOSContentView: some View {
        HStack(spacing: .medium) {
            VStack(alignment: .center, spacing: .large) {
                Spacer()

                if let image {
                    image
                        .resizable()
                        .frame(width: 64, height: 64, alignment: .bottom)
                }

                TextBox(
                    title: title,
                    subtitle: subtitle,
                    spacing: .xxSmall
                )
                .multilineTextAlignment(.center)

                actions

                    .frame(width: 200)

                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .paddingContent()
        .containerRelativeFrame([.horizontal, .vertical])
    }
}
