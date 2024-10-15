//
// Copyright © 2021 Alexander Romanov
// Spacing.swift, created on 11.09.2021
//

import SwiftUI

// swiftlint:disable line_length
public extension HStack {
    @inlinable nonisolated init(alignment: VerticalAlignment = .center, spacing: Space, @ViewBuilder content: () -> Content) {
        self = .init(alignment: alignment, spacing: spacing.rawValue, content: content)
    }
}

public extension VStack {
    @inlinable nonisolated init(alignment: HorizontalAlignment = .center, spacing: Space, @ViewBuilder content: () -> Content) {
        self = .init(alignment: alignment, spacing: spacing.rawValue, content: content)
    }
}

public extension LazyHStack {
    @inlinable nonisolated init(alignment: VerticalAlignment = .center, spacing: Space, @ViewBuilder content: () -> Content) {
        self = .init(alignment: alignment, spacing: spacing.rawValue, content: content)
    }
}

public extension LazyVStack {
    @inlinable nonisolated init(alignment: HorizontalAlignment = .center, spacing: Space, @ViewBuilder content: () -> Content) {
        self = .init(alignment: alignment, spacing: spacing.rawValue, content: content)
    }
}

public extension LazyVGrid {
    @inlinable nonisolated init(columns: [GridItem], alignment: HorizontalAlignment = .center, spacing: Space, pinnedViews: PinnedScrollableViews = .init(), @ViewBuilder content: () -> Content) {
        self = .init(columns: columns, alignment: alignment, spacing: spacing.rawValue, pinnedViews: pinnedViews, content: content)
    }
}

public extension Spacer {
    @MainActor @inlinable @preconcurrency init(minLength: Space) {
        self = .init(minLength: minLength.rawValue)
    }
}

public extension GridItem {
    @inlinable nonisolated init(_ size: GridItem.Size = .flexible(), spacing: Space, alignment: Alignment? = nil) {
        self = .init(size, spacing: spacing.rawValue, alignment: alignment)
    }
}

public extension RoundedRectangle {
    @inlinable nonisolated init(cornerRadius: Radius, style: RoundedCornerStyle = .circular) {
        self = .init(cornerRadius: cornerRadius.rawValue, style: style)
    }
}

public extension EdgeInsets {
    init(top: Space, leading: Space, bottom: Space, trailing: Space) {
        self = .init(top: top.rawValue, leading: leading.rawValue, bottom: bottom.rawValue, trailing: trailing.rawValue)
    }
}

public extension EdgeInsets {
    init(_ all: Space) {
        self = .init(top: all.rawValue, leading: all.rawValue, bottom: all.rawValue, trailing: all.rawValue)
    }
}

public extension EdgeInsets {
    init(horizontal: Space, vertical: Space) {
        self = .init(top: vertical.rawValue, leading: horizontal.rawValue, bottom: vertical.rawValue, trailing: horizontal.rawValue)
    }
}
