//
// Copyright © 2025 Alexander Romanov
// PageViewModifier.swift, created on 07.06.2025
//

import SwiftUI

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 10.0, *)
public extension ListLayoutView {
    func listLayoutStyle(_ listStyle: ListLayoutStyle) -> ListLayoutView {
        var list = self
        list.listStyle = listStyle
        return list
    }
}
