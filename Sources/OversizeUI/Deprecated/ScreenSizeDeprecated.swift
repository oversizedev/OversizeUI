//
// Copyright © 2021 Alexander Romanov
// ScreenSizeDeprecated.swift, created on 10.09.2026
//

import SwiftUI

public extension View {
    @available(*, deprecated, message: "Do not inject ScreenSize into the environment: @Environment(\\.screenSize) resolves the value itself. Use GeometryReader or onGeometryChange for container-specific sizes")
    func screenSize(_ size: ScreenSize) -> some View {
        environment(\.screenSize, size)
    }

    @available(*, deprecated, message: "Do not inject ScreenSize into the environment: @Environment(\\.screenSize) resolves the value itself. Use GeometryReader or onGeometryChange for container-specific sizes")
    func screenSize(_ geometry: GeometryProxy) -> some View {
        environment(\.screenSize, ScreenSize(geometry: geometry))
    }
}
