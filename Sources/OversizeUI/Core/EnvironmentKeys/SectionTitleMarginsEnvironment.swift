//
// Copyright © 2021 Alexander Romanov
// SectionTitleMarginsEnvironment.swift, created on 26.02.2023.
//

import SwiftUI

public extension EnvironmentValues {
    #if os(macOS)
    @Entry var sectionTitleMargins: SwiftUI.EdgeInsets = .init(top: .xSmall, leading: .regular, bottom: .xSmall, trailing: .regular)
    #else
    @Entry var sectionTitleMargins: SwiftUI.EdgeInsets = .init(top: .small, leading: .medium, bottom: .small, trailing: .medium)
    #endif
}

public extension View {
    @ViewBuilder
    func sectionTitleMargins(_ margins: SwiftUI.EdgeInsets) -> some View {
        if #available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *) {
            environment(\.sectionTitleMargins, margins)
                .containerValue(\.sectionTitleMargins, margins)
        } else {
            environment(\.sectionTitleMargins, margins)
        }
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
