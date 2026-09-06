//
// Copyright © 2021 Alexander Romanov
// ScreenSizeEnvironment.swift, created on 10.02.2023
//

import SwiftUI

public enum SectionTitlePosition: Sendable {
    case inside, outside
}

public extension EnvironmentValues {
    @Entry var sectionTitlePosition: SectionTitlePosition = .outside
}

public extension View {
    @ViewBuilder
    func sectionTitlePosition(_ sectionTitlePosition: SectionTitlePosition) -> some View {
        if #available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *) {
            environment(\.sectionTitlePosition, sectionTitlePosition)
                .containerValue(\.sectionTitlePosition, sectionTitlePosition)
        } else {
            environment(\.sectionTitlePosition, sectionTitlePosition)
        }
    }

    @ViewBuilder
    func listSectionTitlePosition(_ position: SectionTitlePosition) -> some View {
        if #available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *) {
            environment(\.sectionTitlePosition, position)
                .containerValue(\.sectionTitlePosition, position)
        } else {
            environment(\.sectionTitlePosition, position)
        }
    }
}
