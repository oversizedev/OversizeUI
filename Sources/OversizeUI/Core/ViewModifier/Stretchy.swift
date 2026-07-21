//
// Copyright © 2026 Alexander Romanov
// Stretchy.swift, created on 13.03.2026
//

import SwiftUI

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
public extension View {
    func stretchy() -> some View {
        visualEffect { effect, geometry in
            let currentHeight = geometry.size.height
            let scrollOffset = geometry.frame(in: .scrollView).minY
            let positiveOffset = max(0, scrollOffset)

            let newHeight = currentHeight + positiveOffset
            let scaleFactor = newHeight / currentHeight

            return effect.scaleEffect(
                x: scaleFactor, y: scaleFactor,
                anchor: .bottom
            )
        }
    }
}
