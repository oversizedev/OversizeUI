//
// Copyright © 2022 Alexander Romanov
// View+Surface.swift
//

import SwiftUI

// swiftlint:disable opening_brace
public extension View {
    func surface(elevation: Elevation = .z0,
                 background: SurfaceColor = .primary,
                 padding: Space = .medium,
                 radius: Radius = .medium) -> some View
    {
        Surface(background: background,
                padding: padding,
                radius: radius) { self }
            .elevation(elevation)
    }

    func surface(elevation: Elevation) -> some View {
        Surface(background: .primary,
                padding: .medium,
                radius: .medium) { self }
            .elevation(elevation)
    }

    func surface(elevation: Elevation, background: SurfaceColor) -> some View {
        Surface(background: background,
                padding: .medium,
                radius: .medium) { self }
            .elevation(elevation)
    }
}
