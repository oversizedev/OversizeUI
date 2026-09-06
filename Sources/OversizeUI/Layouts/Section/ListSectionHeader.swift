//
// Copyright © 2026 Alexander Romanov
// ListSectionHeader.swift, created on 19.03.2026
//

import SwiftUI

public struct ListSectionHeader<Title: StringProtocol, TrailingContent: View>: View {
    @Environment(\.headerProminence) private var headerProminence
    @Environment(\.isNavigatable) private var isNavigatable

    private var trailingContent: (() -> TrailingContent)?
    private let title: Title

    public init(
        title: Title,
        @ViewBuilder trailingContent: @escaping () -> TrailingContent
    ) {
        self.title = title
        self.trailingContent = trailingContent
    }

    public var body: some View {
        @ViewBuilder var titleView: some View {
            HStack(spacing: 2) {
                Text(title)
                    .font(headerProminence == .increased ? .title3.weight(.semibold) : .headline.weight(.semibold))
                    .foregroundStyle(Color.onBackgroundPrimary)

                if isNavigatable {
                    Icon(Image.Base.chevronRight)
                        .iconColor(Color.border)
                        .offset(y: 1)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }

        @ViewBuilder var contentView: some View {
            if let trailingContent {
                HStack {
                    titleView
                    trailingContent()
                }
            } else {
                titleView
            }
        }

        return contentView
    }
}

public extension ListSectionHeader where TrailingContent == EmptyView {
    init(title: Title) {
        self.title = title
    }
}

// MARK: - Previews

#Preview {
    VStack(alignment: .leading, spacing: .medium) {
        ListSectionHeader(title: "Plain header")

        ListSectionHeader(title: "Navigatable header")
            .navigatable()

        ListSectionHeader(title: "With trailing") {
            Button("Edit") {}
        }

        ListSectionHeader(title: "Prominent")
            .headerProminence(.increased)
    }
    .padding()
}
