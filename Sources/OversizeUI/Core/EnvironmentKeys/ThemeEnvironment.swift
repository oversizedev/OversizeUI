//
// Copyright © 2021 Alexander Romanov
// ThemeEnvironment.swift, created on 20.02.2022
//

import SwiftUI

private let defaultThemeSettings = ThemeSettings()

public extension EnvironmentValues {
    @Entry var theme: ThemeSettings = defaultThemeSettings
}

public extension View {
    func theme(_ theme: ThemeSettings) -> some View {
        environment(\.theme, theme)
    }
}
