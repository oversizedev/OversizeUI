//
// Copyright © 2021 Alexander Romanov
// SurfaceStyleEnvironment.swift
//

import SwiftUI

public enum SurfaceStyle {
    case primary
    case secondary
    case tertiary
    case clear
}

public extension EnvironmentValues {
    @Entry var surfaceStyle: SurfaceStyle = .primary
}

public extension View {
    func surfaceStyle(_ style: SurfaceStyle) -> some View {
        environment(\.surfaceStyle, style)
    }
}
