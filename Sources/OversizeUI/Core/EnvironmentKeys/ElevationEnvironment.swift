//
// Copyright © 2021 Alexander Romanov
// ElevationEnvironment.swift, created on 15.11.2021
//

import SwiftUI

private struct ElevationStateKey: EnvironmentKey {
    public static var defaultValue: Elevation = .z0
}

public extension EnvironmentValues {
    var elevation: Elevation {
        get { self[ElevationStateKey.self] }
        set { self[ElevationStateKey.self] = newValue }
    }
}

public extension View {
    func elevation(_ elevation: Elevation = .z0) -> some View {
        environment(\.elevation, elevation)
    }
}
