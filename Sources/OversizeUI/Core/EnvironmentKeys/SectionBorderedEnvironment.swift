//
// Copyright © 2026 Alexander Romanov
// SectionBorderedEnvironment.swift, created on 23.10.2026
//

import SwiftUI

public extension EnvironmentValues {
    @Entry var isSectionBordered: Bool = false
}

public extension View {
    @ViewBuilder
    func sectionBordered(_ isBordered: Bool = true) -> some View {
        if #available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *) {
            environment(\.isSectionBordered, isBordered)
                .containerValue(\.isSectionBordered, isBordered)
        } else {
            environment(\.isSectionBordered, isBordered)
        }
    }
}
