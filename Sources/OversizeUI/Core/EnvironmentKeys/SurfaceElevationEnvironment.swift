//
// Copyright © 2023 Alexander Romanov
// SurfaceElevationEnvironment.swift, created on 27.12.2023
//

import SwiftUI

public extension EnvironmentValues {
    @Entry var surfaceElevation: Elevation = .z0
}

public extension View {
    func surfaceElevation(_ elevation: Elevation = .z0) -> some View {
        environment(\.surfaceElevation, elevation)
    }
}
