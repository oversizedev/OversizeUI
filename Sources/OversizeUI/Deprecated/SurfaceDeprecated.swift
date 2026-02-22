//
// Copyright © 2021 Alexander Romanov
// Surface.swift, created on 14.05.2020
//

import SwiftUI

public extension View {
    @available(*, deprecated, message: "Use without elevation")
    func surface(elevation: Elevation) -> some View {
        Surface { self }
            .elevation(elevation)
    }

    @available(*, deprecated, message: "Use without elevation")
    func surface(elevation: Elevation, background: SurfaceStyle) -> some View {
        Surface { self }
            .surfaceStyle(background)
            .elevation(elevation)
    }

    @available(*, deprecated, message: "Use without elevation")
    func surface(
        elevation: Elevation = .z0,
        background: SurfaceStyle = .primary,
        padding: Space = .medium,
        radius: Space = .xSmall
    ) -> some View {
        Surface { self }
            .surfaceStyle(background)
            .controlPadding(padding)
            .controlRadius(radius)
            .elevation(elevation)
    }
}
