//
// Copyright © 2021 Alexander Romanov
// RadiusEnvironment.swift, created on 26.02.2022
//

import SwiftUI

private struct ControlRadiusKey: EnvironmentKey {
    public static let defaultValue: Radius = .medium
}

public extension EnvironmentValues {
    var controlRadius: Radius {
        get { self[ControlRadiusKey.self] }
        set { self[ControlRadiusKey.self] = newValue }
    }
}

public extension View {
    func controlRadius(_ radius: Radius) -> some View {
        environment(\.controlRadius, radius)
    }
}
