//
// Copyright © 2026 Alexander Romanov
// SectionRowsPaddingEnvironment.swift, created on 13.10.2026
//

import SwiftUI

public extension EnvironmentValues {
    @Entry var sectionRowsPaddingVisibility: Visibility = .automatic
}

public extension View {
    @ViewBuilder
    func sectionRowsPadding(_ visibility: Visibility) -> some View {
        if #available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *) {
            environment(\.sectionRowsPaddingVisibility, visibility)
                .containerValue(\.sectionRowsPaddingVisibility, visibility)
        } else {
            environment(\.sectionRowsPaddingVisibility, visibility)
        }
    }
}
