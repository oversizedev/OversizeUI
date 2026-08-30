//
// Copyright © 2025 Alexander Romanov
// PageViewModifier.swift, created on 07.06.2025
//

import SwiftUI

@available(iOS, deprecated: 18.0, message: "Use ListLayout")
@available(macOS, deprecated: 15.0, message: "Use ListLayout")
@available(tvOS, deprecated: 18.0, message: "Use ListLayout")
@available(watchOS, deprecated: 11.0, message: "Use ListLayout")
@available(visionOS, deprecated: 2.0, message: "Use ListLayout")
public extension ListLayoutView {
    func listLayoutStyle(_ listStyle: ListLayoutStyle) -> ListLayoutView {
        var list = self
        list.listStyle = listStyle
        return list
    }
}
