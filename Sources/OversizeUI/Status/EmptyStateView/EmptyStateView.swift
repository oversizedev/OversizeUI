//
// Copyright © 2024 Alexander Romanov
// BlankView.swift, created on 15.11.2024
//

import SwiftUI

public enum EmptyStateViewType {
    case `default`, compact
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
public struct EmptyStateView<Actions: View>: View {
    private let image: Image?
    private let title: String
    private let subtitle: String?
    @ViewBuilder private let actions: Actions

    var type: EmptyStateViewType = .default

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
        VStack(alignment: .center, spacing: type == .compact ? .medium : .large) {
            if let image {
                image
                    .frame(
                        width: type == .compact ? 64 : 128,
                        height: type == .compact ? 64 : 128,
                        alignment: .bottom
                    )
            }

            TextBox(
                title: title,
                subtitle: subtitle,
                spacing: .xxSmall
            )
            .textBoxSize(type == .compact ? .small : .medium)
            .multilineTextAlignment(.center)

            actions
                #if !os(tvOS)
                .controlSize(type == .compact ? .small : .large)
                #endif
        }
        .padding(.top, .regular)
        .paddingContent()
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

// MARK: - Previews

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("Title only") {
    EmptyStateView(title: "No results")
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("With actions") {
    EmptyStateView(
        image: Image.Base.search,
        title: "Nothing here yet",
        subtitle: "Items you add will show up in this list"
    ) {
        Button("Add item") {}
        Button("Learn more") {}
    }
}
