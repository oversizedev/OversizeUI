//
// Copyright © 2025 Alexander Romanov
// PageViewModifier.swift, created on 07.06.2025
//

import SwiftUI

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
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

    func contentCornerRadius(_ radius: Radius) -> Self {
        var control = self
        control.contentCornerRadius = radius.rawValue
        return control
    }
}
