//
// Copyright © 2021 Alexander Romanov
// ElevationEnvironment.swift, created on 15.11.2021
//

import SwiftUI

public extension EnvironmentValues {
    @Entry var elevation: Elevation = .z0
}

public extension View {
    func elevation(_ elevation: Elevation = .z0) -> some View {
        environment(\.elevation, elevation)
    }
}
