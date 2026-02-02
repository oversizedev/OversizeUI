//
// Copyright © 2021 Alexander Romanov
// RadiusEnvironment.swift, created on 26.02.2022
//

import SwiftUI

public extension EnvironmentValues {
    @Entry var controlRadius: CGFloat = .xSmall
}

public extension View {
    func controlRadius(_ radius: Space) -> some View {
        environment(\.controlRadius, radius.rawValue)
    }
}
