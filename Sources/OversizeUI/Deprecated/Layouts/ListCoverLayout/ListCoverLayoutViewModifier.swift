//
// Copyright © 2025 Alexander Romanov
// PageViewModifier.swift, created on 07.06.2025
//

import SwiftUI

@available(iOS, introduced: 17.0, deprecated: 18.0, message: "Use ListCoverLayout")
@available(macOS, introduced: 14.0, deprecated: 15.0, message: "Use ListCoverLayout")
@available(tvOS, introduced: 17.0, deprecated: 18.0, message: "Use ListCoverLayout")
@available(watchOS, introduced: 10.0, deprecated: 11.0, message: "Use ListCoverLayout")
@available(visionOS, introduced: 1.0, deprecated: 2.0, message: "Use ListCoverLayout")
public extension ListCoverLayoutView {
    func listLayoutStyle(_ listStyle: ListLayoutStyle) -> Self {
        var list = self
        list.listStyle = listStyle
        return list
    }

    func coverSpacing(_ spacing: CGFloat?) -> Self {
        var list = self
        list.contentMarginTop = spacing
        return list
    }
}
