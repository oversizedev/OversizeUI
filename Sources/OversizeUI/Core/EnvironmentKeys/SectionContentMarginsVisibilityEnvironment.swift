//
// Copyright © 2026 Alexander Romanov
// ListSectionTitleSeparatorEnvironment.swift, created on 24.05.2026
//

import SwiftUI

public extension EnvironmentValues {
    @Entry var sectionContentMarginsVisibility: Visibility = .automatic
}

public extension View {
    func sectionContentMarginsVisibility(_ visibility: Visibility) -> some View {
        environment(\.sectionContentMarginsVisibility, visibility)
    }
}
