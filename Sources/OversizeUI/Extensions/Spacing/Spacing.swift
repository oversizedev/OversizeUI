//
// Copyright © 2022 Alexander Romanov
// Spacing.swift
//

import SwiftUI

// swiftlint:disable line_length
public extension HStack {
    init(alignment: VerticalAlignment = .center, spacing: Space, @ViewBuilder content: () -> Content) {
        self = .init(alignment: alignment, spacing: spacing.rawValue, content: content)
    }
}

public extension VStack {
    init(alignment: HorizontalAlignment = .center, spacing: Space, @ViewBuilder content: () -> Content) {
        self = .init(alignment: alignment, spacing: spacing.rawValue, content: content)
    }
}

public extension LazyHStack {
    init(alignment: VerticalAlignment = .center, spacing: Space, @ViewBuilder content: () -> Content) {
        self = .init(alignment: alignment, spacing: spacing.rawValue, content: content)
    }
}

public extension LazyVStack {
    init(alignment: HorizontalAlignment = .center, spacing: Space, @ViewBuilder content: () -> Content) {
        self = .init(alignment: alignment, spacing: spacing.rawValue, content: content)
    }
}

public extension LazyVGrid {
    init(columns: [GridItem], alignment: HorizontalAlignment = .center, spacing: Space, pinnedViews: PinnedScrollableViews = .init(), @ViewBuilder content: () -> Content) {
        self = .init(columns: columns, alignment: alignment, spacing: spacing.rawValue, pinnedViews: pinnedViews, content: content)
    }
}

public extension Spacer {
    init(minLength: Space) {
        self = .init(minLength: minLength.rawValue)
    }
}

public extension GridItem {
    init(_ size: GridItem.Size = .flexible(), spacing: Space, alignment: Alignment? = nil) {
        self = .init(size, spacing: spacing.rawValue, alignment: alignment)
    }
}
