//
// Copyright © 2021 Alexander Romanov
// ThemeEnvironment.swift, created on 20.02.2022
//

import SwiftUI

public extension EnvironmentValues {
    @Entry var theme: ThemeSettings = .init()
}

public extension View {
    func theme(_ theme: ThemeSettings) -> some View {
        environment(\.theme, theme)
    }
}
