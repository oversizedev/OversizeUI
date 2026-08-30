//
// Copyright © 2025 Alexander Romanov
// PageViewModifier.swift, created on 07.06.2025
//

import SwiftUI

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
public extension ListLayout {
    func listLayoutStyle(_ listStyle: ListLayoutStyle) -> ListLayout {
        var list = self
        list.listStyle = listStyle
        return list
    }
}
