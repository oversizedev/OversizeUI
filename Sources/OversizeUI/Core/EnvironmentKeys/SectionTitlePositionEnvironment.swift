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
    func sectionTitlePosition(_ sectionTitlePosition: SectionTitlePosition) -> some View {
        environment(\.sectionTitlePosition, sectionTitlePosition)
    }

    func listSectionTitlePosition(_ sectionTitlePosition: SectionTitlePosition) -> some View {
        environment(\.sectionTitlePosition, sectionTitlePosition)
    }
}
