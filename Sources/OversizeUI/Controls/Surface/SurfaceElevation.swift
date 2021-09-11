//
// Copyright © 2021 Alexander Romanov
// Created on 26.08.2021
//

import SwiftUI

public struct SurfaceElevationModifier: ViewModifier {
    public var elevation: Elevation

    public func body(content: Content) -> some View {
        content
            .modifier(Shadow(elevation: elevation))
    }
}

public extension Surface {
    @ViewBuilder
    func elevation(_ elevation: Elevation) -> some View {
        modifier(SurfaceElevationModifier(elevation: elevation))
    }
}
