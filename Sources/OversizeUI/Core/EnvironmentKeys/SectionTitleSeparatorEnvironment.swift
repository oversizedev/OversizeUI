//
// Copyright © 2026 Alexander Romanov
// ListSectionTitleSeparatorEnvironment.swift, created on 24.05.2026
//

import SwiftUI

public extension EnvironmentValues {
    @Entry var sectionTitleSeparator: Visibility = .automatic
}

public extension View {
    @ViewBuilder
    func sectionTitleSeparator(_ visibility: Visibility) -> some View {
        if #available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *) {
            environment(\.sectionTitleSeparator, visibility)
                .containerValue(\.sectionTitleSeparator, visibility)
        } else {
            environment(\.sectionTitleSeparator, visibility)
        }
    }
}
