//
// Copyright © 2024 Alexander Romanov
// MultiSelectStyleEnvironment.swift, created on 03.03.2024
//

import SwiftUI

public enum MultiSelectStyle: Sendable {
    case `default`, section
}

public extension EnvironmentValues {
    @Entry var multiSelectStyle: MultiSelectStyle = .default
}

public extension View {
    func multiSelectStyle(_ multiSelectStyle: MultiSelectStyle) -> some View {
        environment(\.multiSelectStyle, multiSelectStyle)
    }
}
