//
// Copyright © 2023 Alexander Romanov
// SurfaceRadiusEnvironment.swift, created on 25.03.2023
//

import SwiftUI

public extension EnvironmentValues {
    @Entry var surfaceRadius: CGFloat = .xSmall
}

public extension View {
    func surfaceRadius(_ radius: Space) -> some View {
        environment(\.surfaceRadius, radius.rawValue)
    }
}
