//
// Copyright © 2021 Alexander Romanov
// Created on 12.09.2021
//

import SwiftUI
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
