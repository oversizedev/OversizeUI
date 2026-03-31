//
// Copyright © 2021 Alexander Romanov
// ViewIconOnSurface.swift, created on 14.02.2023.
//

import SwiftUI

public extension View {
    func iconOnSurface(_ surfaceStyle: SurfaceStyle = .secondary, surfaceSolor: Color? = nil) -> some View {
        Surface {
            self.foregroundColor(Color.onSurfacePrimary)
        }
        .surfaceBackgroundColor(surfaceSolor)
        .surfaceStyle(surfaceStyle)
        .surfaceContentMargins(.xxSmall)
        .surfaceRadius(.medium)
    }
}
