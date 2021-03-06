//
// Copyright © 2022 Alexander Romanov
// Shadow.swift
//

import SwiftUI

public struct Shadow: ViewModifier {
    var elevation: Elevation

    var color: Color = .black

    public func body(content: Content) -> some View {
        switch elevation {
        case .z0:
            return content
                .shadow(color: .clear,
                        radius: 0,
                        x: 0,
                        y: 0)
        case .z1:
            return content
                .shadow(color: color.opacity(0.08),
                        radius: 8,
                        x: 0,
                        y: 2)
        case .z2:
            return content
                .shadow(color: color.opacity(0.08),
                        radius: 16,
                        x: 0,
                        y: 4)
        case .z3:
            return content
                .shadow(color: color.opacity(0.12),
                        radius: 24,
                        x: 0,
                        y: 8)
        case .z4:
            return content
                .shadow(color: color.opacity(0.16),
                        radius: 34,
                        x: 0,
                        y: 12)
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
