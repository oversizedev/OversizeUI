//
// Copyright © 2026 Alexander Romanov
// IconSizeKey.swift, created on 26.03.2026
//

import SwiftUI

public extension EnvironmentValues {
    @Entry var iconColor: Color?
}

public extension View {
    func iconColor(_ color: Color?) -> some View {
        environment(\.iconColor, color)
    }
}
