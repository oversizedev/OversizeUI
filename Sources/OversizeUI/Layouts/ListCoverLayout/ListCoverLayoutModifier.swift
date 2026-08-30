//
// Copyright © 2026 Alexander Romanov
// ListCoverLayoutModifier.swift, created on 30.08.2026
//

import SwiftUI

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
public extension ListCoverLayout {
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
