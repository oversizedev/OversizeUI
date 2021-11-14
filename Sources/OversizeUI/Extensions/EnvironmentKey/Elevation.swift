//
//  File.swift
//  
//
//  Created by alexander on 15.11.2021.
//

import SwiftUI

struct ElevationStateKey: EnvironmentKey {
    public static var defaultValue: Elevation = .z1
}

public extension EnvironmentValues {
    var elevation: Elevation {
        get { self[ElevationStateKey.self] }
        set { self[ElevationStateKey.self] = newValue }
    }
}

public extension View {
    @ViewBuilder
    func elevation(_ elevation: Elevation = .z1) -> some View {
        environment(\.elevation, elevation)
    }
}
