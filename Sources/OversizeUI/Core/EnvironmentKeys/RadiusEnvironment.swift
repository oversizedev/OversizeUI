//
// Copyright © 2021 Alexander Romanov
// RadiusEnvironment.swift, created on 26.02.2022
//

import SwiftUI

private struct ControlRadiusKey: EnvironmentKey {
    static let defaultValue: CGFloat = .xSmall
}

public extension EnvironmentValues {
    var controlRadius: CGFloat {
        get { self[ControlRadiusKey.self] }
        set { self[ControlRadiusKey.self] = newValue }
    }
}

public extension View {
    func controlRadius(_ radius: Space) -> some View {
        environment(\.controlRadius, radius.rawValue)
    }
}
