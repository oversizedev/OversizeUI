//
// Copyright © 2024 Alexander Romanov
// MultiSelectStyleEnvironment.swift, created on 03.03.2024
//

import SwiftUI

public enum MultiSelectStyle {
    case `default`, section
}
private struct MultiSelectStyleKey: EnvironmentKey {
    public static var defaultValue: MultiSelectStyle = .default
}

public extension EnvironmentValues {
    var multiSelectStyle: MultiSelectStyle {
        get { self[MultiSelectStyleKey.self] }
        set { self[MultiSelectStyleKey.self] = newValue }
    }
}

public extension View {
    func multiSelectStyle(_ multiSelectStyle: MultiSelectStyle) -> some View {
        environment(\.multiSelectStyle, multiSelectStyle)
    }
}
