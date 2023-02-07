//
// Copyright © 2022 Alexander Romanov
// Spacing.swift
//

import SwiftUI

// swiftlint:disable line_length
public extension HStack {
    @inlinable init(alignment: VerticalAlignment = .center, spacing: Space, @ViewBuilder content: () -> Content) {
        self = .init(alignment: alignment, spacing: spacing.rawValue, content: content)
    }
}

public extension VStack {
    @inlinable init(alignment: HorizontalAlignment = .center, spacing: Space, @ViewBuilder content: () -> Content) {
        self = .init(alignment: alignment, spacing: spacing.rawValue, content: content)
    }
}

public extension LazyHStack {
    @inlinable init(alignment: VerticalAlignment = .center, spacing: Space, @ViewBuilder content: () -> Content) {
        self = .init(alignment: alignment, spacing: spacing.rawValue, content: content)
    }
}

public extension LazyVStack {
    @inlinable init(alignment: HorizontalAlignment = .center, spacing: Space, @ViewBuilder content: () -> Content) {
        self = .init(alignment: alignment, spacing: spacing.rawValue, content: content)
    }
}

public extension LazyVGrid {
    @inlinable init(columns: [GridItem], alignment: HorizontalAlignment = .center, spacing: Space, pinnedViews: PinnedScrollableViews = .init(), @ViewBuilder content: () -> Content) {
        self = .init(columns: columns, alignment: alignment, spacing: spacing.rawValue, pinnedViews: pinnedViews, content: content)
    }
}

public extension Spacer {
    @inlinable init(minLength: Space) {
        self = .init(minLength: minLength.rawValue)
    }
}

public extension GridItem {
    @inlinable init(_ size: GridItem.Size = .flexible(), spacing: Space, alignment: Alignment? = nil) {
        self = .init(size, spacing: spacing.rawValue, alignment: alignment)
    }
}

public extension RoundedRectangle {
    @inlinable init(cornerRadius: Radius, style: RoundedCornerStyle = .circular) {
        self = .init(cornerRadius: cornerRadius.rawValue, style: style)
    }
}

public extension EdgeInsets {
    init(top: Space, leading: Space, bottom: Space, trailing: Space) {
        self = .init(top: top.rawValue, leading: leading.rawValue, bottom: bottom.rawValue, trailing: trailing.rawValue)
    }
}
