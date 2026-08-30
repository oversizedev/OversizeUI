//
// Copyright © 2026 Alexander Romanov
// CoverLayoutModifier.swift, created on 30.08.2026
//

import SwiftUI

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
public extension CoverLayout {
    func coverStyle(_ coverStyle: CoverNavigationType) -> Self {
        var control = self
        control.coverStyle = coverStyle
        return control
    }

    func contentCornerRadius(_ radius: CGFloat) -> Self {
        var control = self
        control.contentCornerRadius = radius
        return control
    }

    func contentOffset(_ contentOffset: CGFloat) -> Self {
        var control = self
        control.contentOffset = contentOffset
        return control
    }
}
