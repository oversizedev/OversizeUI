//
// Copyright © 2026 Alexander Romanov
// ListSectionHeader.swift, created on 19.03.2026
//

import SwiftUI

public enum SectionHeaderStyle {
    case primary
    case secondary
}

public struct ListSectionHeader<Title: StringProtocol, TrailingContent: View>: View {

    private var trailingContent: (() -> TrailingContent)?
    private let title: Title
    private let style: SectionHeaderStyle
    
    public init(
        title: Title,
        style: SectionHeaderStyle,
        @ViewBuilder trailingContent: @escaping () -> TrailingContent
    ) {
        self.title = title
        self.trailingContent = trailingContent
        self.style = style
    }

    public var body: some View {

        @ViewBuilder var titleView: some View {
            Text(title)
                .font(.headline.weight(.semibold))
                .foregroundStyle(Color.onBackgroundPrimary)
        }

        @ViewBuilder var contentView: some View {
            if let trailingContent {
                HStack {
                    titleView
                    Spacer(minLength: 0)
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
        self.style = .primary
    }
}

public extension ListSectionHeader where TrailingContent == EmptyView {
    init(title: Title, style: SectionHeaderStyle) {
        self.title = title
        self.style = style
    }
}
