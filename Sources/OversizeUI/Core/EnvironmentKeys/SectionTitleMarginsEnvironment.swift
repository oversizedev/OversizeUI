//
// Copyright © 2021 Alexander Romanov
// SectionTitleMarginsEnvironment.swift, created on 26.02.2023.
//

import SwiftUI

private struct SectionTitleMarginsKey: EnvironmentKey {
    static let defaultValue: EdgeSpaceInsets = .init(top: .zero, leading: .zero, bottom: .zero, trailing: .zero)
}

public extension EnvironmentValues {
    var sectionTitleMargins: EdgeSpaceInsets {
        get { self[SectionTitleMarginsKey.self] }
        set { self[SectionTitleMarginsKey.self] = newValue }
    }
}

public extension View {
    func sectionTitleMargins(_ margins: EdgeSpaceInsets) -> some View {
        environment(\.sectionTitleMargins, margins)
    }

    func sectionContentRowMargins() -> some View {
        environment(\.sectionTitleMargins, .init(top: .zero, leading: .medium, bottom: .zero, trailing: .medium))
            .environment(\.surfaceContentMargins, .init(top: .medium, leading: .zero, bottom: .medium, trailing: .zero))
    }

    func sectionContentCompactRowMargins() -> some View {
        environment(\.sectionTitleMargins, .init(top: .zero, leading: .medium, bottom: .zero, trailing: .medium))
            .environment(\.surfaceContentMargins, .init(top: .xxSmall, leading: .zero, bottom: .xxSmall, trailing: .zero))
    }
}

// MARK: Deprecated methods

public extension View {
    @available(*, deprecated, renamed: "sectionTitleMargins")
    func sectionTitleInsets(_ insets: EdgeSpaceInsets) -> some View {
        environment(\.sectionTitleMargins, insets)
    }

    @available(*, deprecated, renamed: "sectionContentRowMargins")
    func sectionContentRowInsets() -> some View {
        environment(\.sectionTitleMargins, .init(top: .zero, leading: .medium, bottom: .zero, trailing: .medium))
            .environment(\.surfaceContentMargins, .init(top: .medium, leading: .zero, bottom: .medium, trailing: .zero))
    }

    @available(*, deprecated, renamed: "sectionContentCompactRowMargins")
    func sectionContentCompactRowInsets() -> some View {
        environment(\.sectionTitleMargins, .init(top: .zero, leading: .medium, bottom: .zero, trailing: .medium))
            .environment(\.surfaceContentMargins, .init(top: .xxSmall, leading: .zero, bottom: .xxSmall, trailing: .zero))
    }
}
