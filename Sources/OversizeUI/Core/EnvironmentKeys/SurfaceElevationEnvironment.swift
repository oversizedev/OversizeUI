//
// Copyright © 2023 Alexander Romanov
// SurfaceElevationEnvironment.swift, created on 27.12.2023
//

import SwiftUI

private struct SurfaceElevationStateKey: EnvironmentKey {
    public static let defaultValue: Elevation = .z0
}

public extension EnvironmentValues {
    var surfaceElevation: Elevation {
        get { self[SurfaceElevationStateKey.self] }
        set { self[SurfaceElevationStateKey.self] = newValue }
    }
}

public extension View {
    func surfaceElevation(_ elevation: Elevation = .z0) -> some View {
        environment(\.surfaceElevation, elevation)
    }
}
