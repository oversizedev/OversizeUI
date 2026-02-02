//
// Copyright © 2024 Alexander Romanov
// SelectStyleEnvironment.swift, created on 01.03.2024
//

import SwiftUI

public enum SelectStyle: Sendable {
    case `default`
    case section
    @available(macOS, unavailable)
    case wheel
}

public extension EnvironmentValues {
    @Entry var selectStyle: SelectStyle = .default
}

public extension View {
    func selectStyle(_ selectStyle: SelectStyle) -> some View {
        environment(\.selectStyle, selectStyle)
    }
}
