//
// Copyright © 2022 Alexander Romanov
// View+Surface.swift
//

import SwiftUI

// swiftlint:disable opening_brace
public extension View {
    func surface() -> some View {
        Surface { self }
    }

    func surface(elevation: Elevation) -> some View {
        Surface { self }
            .elevation(elevation)
    }

    func surface(elevation: Elevation, background: SurfaceStyle) -> some View {
        Surface { self }
            .surfaceStyle(background)
            .elevation(elevation)
    }

    func surface(elevation: Elevation = .z0,
                 background: SurfaceStyle = .primary,
                 padding: Space = .medium,
                 radius: Radius = .medium) -> some View
    {
        Surface { self }
            .surfaceStyle(background)
            .controlPadding(padding)
            .controlRadius(radius)
            .elevation(elevation)
    }
}
