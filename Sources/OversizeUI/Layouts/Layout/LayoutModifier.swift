//
// Copyright © 2026 Alexander Romanov
// LayoutModifier.swift, created on 06.09.2026
//

import SwiftUI

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
public extension Layout {
    func listLayoutStyle(_ listStyle: ListLayoutStyle) -> Self {
        var layout = self
        layout.listStyle = listStyle
        return layout
    }
}
