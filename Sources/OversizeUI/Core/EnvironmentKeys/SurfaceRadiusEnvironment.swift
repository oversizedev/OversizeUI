//
// Copyright © 2023 Alexander Romanov
// SurfaceRadiusEnvironment.swift, created on 25.03.2023
//

import SwiftUI

private struct SurfaceRadiusKey: EnvironmentKey {
    static let defaultValue: CGFloat = .xSmall
}

public extension EnvironmentValues {
    var surfaceRadius: CGFloat {
        get { self[SurfaceRadiusKey.self] }
        set { self[SurfaceRadiusKey.self] = newValue }
    }
}

public extension View {
    func surfaceRadius(_ radius: Space) -> some View {
        environment(\.surfaceRadius, radius.rawValue)
    }
}
