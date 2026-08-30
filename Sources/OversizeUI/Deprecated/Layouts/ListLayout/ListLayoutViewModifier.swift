//
// Copyright © 2025 Alexander Romanov
// PageViewModifier.swift, created on 07.06.2025
//

import SwiftUI

@available(iOS, introduced: 16.0, deprecated: 18.0, message: "Use ListLayout")
@available(macOS, introduced: 13.0, deprecated: 15.0, message: "Use ListLayout")
@available(tvOS, introduced: 16.0, deprecated: 18.0, message: "Use ListLayout")
@available(watchOS, introduced: 10.0, deprecated: 11.0, message: "Use ListLayout")
@available(visionOS, introduced: 1.0, deprecated: 2.0, message: "Use ListLayout")
public extension ListLayoutView {
    func listLayoutStyle(_ listStyle: ListLayoutStyle) -> ListLayoutView {
        var list = self
        list.listStyle = listStyle
        return list
    }
}
