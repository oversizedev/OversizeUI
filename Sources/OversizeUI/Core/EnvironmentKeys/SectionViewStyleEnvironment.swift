//
// Copyright © 2021 Alexander Romanov
// ScreenSizeEnvironment.swift, created on 10.02.2023
//

import SwiftUI

private struct SectionViewStyleKey: EnvironmentKey {
    public static let defaultValue: SectionViewStyle = .default
}

public extension EnvironmentValues {
    var sectionViewStyle: SectionViewStyle {
        get { self[SectionViewStyleKey.self] }
        set { self[SectionViewStyleKey.self] = newValue }
    }
}

public extension View {
    func sectionViewStyle(_ sectionViewStyle: SectionViewStyle) -> some View {
        environment(\.sectionViewStyle, sectionViewStyle)
    }
}
