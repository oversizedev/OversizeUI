//
// Copyright © 2021 Alexander Romanov
// SectionTitleMarginsEnvironment.swift, created on 26.02.2023.
//

import SwiftUI

public extension EnvironmentValues {
    @Entry var sectionTitleMargins: EdgeInsets = .init(top: .zero, leading: .zero, bottom: .zero, trailing: .zero)
}

public extension View {
    func sectionTitleMargins(_ margins: EdgeInsets) -> some View {
        environment(\.sectionTitleMargins, margins)
    }

    func sectionContentRowMargins() -> some View {
        environment(\.sectionTitleMargins, .init(top: .zero, leading: .medium, bottom: .zero, trailing: .medium))
            .environment(\.surfaceContentMargins, .init(top: .medium, leading: .zero, bottom: .medium, trailing: .zero))
    }

    func sectionContentCompactRowMargins() -> some View {
        #if os(macOS)
        environment(\.sectionTitleMargins, .init(top: .zero, leading: .medium, bottom: .zero, trailing: .medium))
            .environment(\.surfaceContentMargins, .init(top: .xxxSmall, leading: .zero, bottom: .xxxSmall, trailing: .zero))
        #else
        environment(\.sectionTitleMargins, .init(top: .zero, leading: .medium, bottom: .zero, trailing: .medium))
            .environment(\.surfaceContentMargins, .init(top: .xxSmall, leading: .zero, bottom: .xxSmall, trailing: .zero))
        #endif
    }
}
