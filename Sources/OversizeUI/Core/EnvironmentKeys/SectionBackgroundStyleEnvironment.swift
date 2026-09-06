//
// Copyright © 2026 Alexander Romanov
// SectionBackgroundStyleEnvironment.swift, created on 05.09.2026
//

import SwiftUI

public enum SectionBackgroundStyle: Sendable {
    /// Surface card with an optional solid border
    case surface
    /// Dashed border without a fill
    case dotted
    /// No background and no border
    case plain
}

public extension EnvironmentValues {
    @Entry var sectionBackgroundStyle: SectionBackgroundStyle = .surface
}

public extension View {
    @ViewBuilder
    func sectionBackgroundStyle(_ style: SectionBackgroundStyle) -> some View {
        if #available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *) {
            environment(\.sectionBackgroundStyle, style)
                .containerValue(\.sectionBackgroundStyle, style)
        } else {
            environment(\.sectionBackgroundStyle, style)
        }
    }
}
