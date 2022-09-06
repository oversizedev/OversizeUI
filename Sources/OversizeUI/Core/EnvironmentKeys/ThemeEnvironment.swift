//
// Copyright © 2022 Alexander Romanov
// ThemeEnvironment.swift
//

import SwiftUI

private struct ThemeStateKey: EnvironmentKey {
    public static var defaultValue = ThemeSettings()
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
