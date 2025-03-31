//
// Copyright © 2023 Alexander Romanov
// SurfaceRadiusEnvironment.swift, created on 25.03.2023
//

import SwiftUI

private struct SurfaceRadiusKey: EnvironmentKey {
    public static let defaultValue: Radius = .medium
}

public extension EnvironmentValues {
    var surfaceRadius: Radius {
        get { self[SurfaceRadiusKey.self] }
        set { self[SurfaceRadiusKey.self] = newValue }
    }
}

public extension View {
    func surfaceRadius(_ radius: Radius) -> some View {
        environment(\.surfaceRadius, radius)
    }
}
