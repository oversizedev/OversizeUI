//
// Copyright © 2021 Alexander Romanov
// Shadow.swift, created on 31.05.2020
//

import SwiftUI

public struct Shadow: ViewModifier {
    private let elevation: Elevation

    private let color: Color

    public init(elevation: Elevation, color: Color = .black) {
        self.elevation = elevation
        self.color = color
    }

    public func body(content: Content) -> some View {
        switch elevation {
        case .z0:
            content
                .shadow(
                    color: .clear,
                    radius: 0,
                    x: 0,
                    y: 0
                )
        case .z1:
            content
                .shadow(
                    color: color.opacity(0.08),
                    radius: 8,
                    x: 0,
                    y: 2
                )
        case .z2:
            content
                .shadow(
                    color: color.opacity(0.08),
                    radius: 16,
                    x: 0,
                    y: 4
                )
        case .z3:
            content
                .shadow(
                    color: color.opacity(0.12),
                    radius: 24,
                    x: 0,
                    y: 8
                )
        case .z4:
            content
                .shadow(
                    color: color.opacity(0.16),
                    radius: 34,
                    x: 0,
                    y: 12
                )
        }
    }
}

public extension View {
    func shadowElevaton(_ elevation: Elevation) -> some View {
        modifier(Shadow(elevation: elevation))
    }

    func shadowElevaton(_ elevation: Elevation, color: Color) -> some View {
        modifier(Shadow(elevation: elevation, color: color))
    }
}
