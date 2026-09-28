//
// Copyright © 2026 Alexander Romanov
// CalendarLayoutModifier.swift, created on 27.09.2026
//

import SwiftUI

@available(iOS 18.0, *)
@available(macOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
public extension CalendarLayout {
    func listLayoutStyle(_ listStyle: ListLayoutStyle) -> Self {
        var layout = self
        layout.listStyle = listStyle
        return layout
    }
}
