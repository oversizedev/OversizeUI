//
// Copyright © 2021 Alexander Romanov
// ThemeEnvironment.swift, created on 20.02.2022
//

import SwiftUI

private struct ThemeStateKey: EnvironmentKey {
    public static let defaultValue = ThemeSettings()
}

public extension EnvironmentValues {
    var theme: ThemeSettings {
        get { self[ThemeStateKey.self] }
        set { self[ThemeStateKey.self] = newValue }
    }
}

public extension View {
    func theme(_ theme: ThemeSettings) -> some View {
        environment(\.theme, theme)
    }
}
