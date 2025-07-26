//
// Copyright © 2025 Alexander Romanov
// HUDContent.swift, created on 19.07.2025
//

import SwiftUI

public struct HUDContent<Title, Icon>: View where Title: View, Icon: View {
    private let text: String?
    private let title: Title?
    private let icon: Icon?

    public init(
        text: String? = nil,
        title: Title? = nil,
        icon: Icon? = nil
    ) {
        self.text = text
        self.title = title
        self.icon = icon
    }

    public var body: some View {
        HStack(spacing: .xxSmall) {
            if icon != nil {
                icon
            }
            if let text {
                Text(text)
                    .body(.medium)
                #if os(macOS)
                    .foregroundColor(Color.onPrimary)
                #else
                    .foregroundColor(Color.onSurfacePrimary)
                #endif
            } else if let title {
                title
            }
        }
        .padding(.leading, icon == nil ? .medium : .xSmall)
        .padding(.trailing, .medium)
        .padding(.vertical, .xSmall)
        #if os(macOS)
            .background(
                RoundedRectangle(cornerRadius: .small, style: .continuous)
                    .foregroundColor(Color.onBackgroundPrimary)
                    .shadowElevation(.z2)
            )
        #else
            .background(
                Capsule()
                    .foregroundColor(Color.surfacePrimary)
                    .shadowElevation(.z2)
            )
        #endif
    }
}

// MARK: - Convenience Extensions

public extension HUDContent where Title == EmptyView, Icon == EmptyView {
    init(_ text: String) {
        self.text = text
        title = nil
        icon = nil
    }
}

public extension HUDContent where Title == EmptyView {
    init(_ text: String, icon: Icon) {
        self.text = text
        title = nil
        self.icon = icon
    }
}

public extension HUDContent where Icon == EmptyView {
    init(title: Title) {
        text = nil
        self.title = title
        icon = nil
    }
}
