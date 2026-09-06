//
// Copyright © 2026 Alexander Romanov
// ListSectionTitleSeparatorEnvironment.swift, created on 24.05.2026
//

import SwiftUI

public extension EnvironmentValues {
    @Entry var sectionContentMarginsVisibility: Visibility = .automatic
}

public extension View {
    @ViewBuilder
    func sectionContentMarginsVisibility(_ visibility: Visibility) -> some View {
        if #available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *) {
            environment(\.sectionContentMarginsVisibility, visibility)
                .containerValue(\.sectionContentMarginsVisibility, visibility)
        } else {
            environment(\.sectionContentMarginsVisibility, visibility)
        }
    }
}
