//
// Copyright © 2025 Alexander Romanov
// PageViewModifier.swift, created on 07.06.2025
//

import SwiftUI

@available(iOS, introduced: 17.0, deprecated: 18.0, message: "Use CoverLayout")
@available(macOS, introduced: 14.0, deprecated: 15.0, message: "Use CoverLayout")
@available(tvOS, introduced: 17.0, deprecated: 18.0, message: "Use CoverLayout")
@available(watchOS, introduced: 10.0, deprecated: 11.0, message: "Use CoverLayout")
@available(visionOS, introduced: 1.0, deprecated: 2.0, message: "Use CoverLayout")
public extension CoverLayoutView {
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
