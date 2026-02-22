//
// Copyright © 2021 Alexander Romanov
// Shadow.swift, created on 31.05.2020
//

import SwiftUI

public extension View {
    @available(*, deprecated, renamed: "shadowElevation")
    func shadowElevaton(_ elevation: Elevation) -> some View {
        modifier(Shadow(elevation: elevation))
    }

    @available(*, deprecated, renamed: "shadowElevation")
    func shadowElevaton(_ elevation: Elevation, color: Color) -> some View {
        modifier(Shadow(elevation: elevation, color: color))
    }
}
