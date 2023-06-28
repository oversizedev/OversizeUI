//
// Copyright © 2021 Alexander Romanov
// SectionTitleInsetsEnvironment.swift, created on 26.02.2023.
//

import SwiftUI

private struct SectionTitleInsetsKey: EnvironmentKey {
    static let defaultValue: EdgeSpaceInsets = .init(top: .zero, leading: .zero, bottom: .zero, trailing: .zero)
}

public extension EnvironmentValues {
    var sectionTitleInsets: EdgeSpaceInsets {
        get { self[SectionTitleInsetsKey.self] }
        set { self[SectionTitleInsetsKey.self] = newValue }
    }
}

public extension View {
    func sectionTitleInsets(_ insets: EdgeSpaceInsets) -> some View {
        environment(\.sectionTitleInsets, insets)
    }

    func sectionContentRowInsets() -> some View {
        environment(\.sectionTitleInsets, .init(top: .zero, leading: .medium, bottom: .zero, trailing: .medium))
            .environment(\.surfaceContentInsets, .init(top: .medium, leading: .zero, bottom: .medium, trailing: .zero))
    }
    
    func sectionContentCompactRowInsets() -> some View {
        environment(\.sectionTitleInsets, .init(top: .zero, leading: .medium, bottom: .zero, trailing: .medium))
            .environment(\.surfaceContentInsets, .init(top: .xxSmall, leading: .zero, bottom: .xxSmall, trailing: .zero))
    }
}
