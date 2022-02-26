//
// Copyright © 2022 Alexander Romanov
// RadiusEnvironment.swift
//

import SwiftUI

private struct ControlRadiusKey: EnvironmentKey {
    public static var defaultValue: Radius = .medium
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
