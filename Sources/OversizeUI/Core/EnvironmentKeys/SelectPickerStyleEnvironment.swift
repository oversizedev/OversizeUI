//
// Copyright © 2024 Alexander Romanov
// SelectStyleEnvironment.swift, created on 01.03.2024
//

import SwiftUI

public enum SelectStyle {
    case `default`
    case section
    @available(macOS, unavailable)
    case wheel
}

private struct SelectStyleKey: EnvironmentKey {
    public static var defaultValue: SelectStyle = .default
}

public extension EnvironmentValues {
    var selectStyle: SelectStyle {
        get { self[SelectStyleKey.self] }
        set { self[SelectStyleKey.self] = newValue }
    }
}

public extension View {
    func selectStyle(_ selectStyle: SelectStyle) -> some View {
        environment(\.selectStyle, selectStyle)
    }
}
