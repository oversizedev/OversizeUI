//
// Copyright © 2026 Alexander Romanov
// IconSizeKey.swift, created on 26.03.2026
//

import SwiftUI

public extension EnvironmentValues {
    @Entry var iconSize: CGFloat = IconSizes.medium.rawValue
}

public extension View {
    func iconSize(_ size: IconSizes) -> some View {
        environment(\.iconSize, size.rawValue)
    }

    func iconSize(custom size: CGFloat) -> some View {
        environment(\.iconSize, size)
    }
}
