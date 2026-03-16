//
// Copyright © 2021 Alexander Romanov
// RowContentMarginsEnvironment.swift, created on 07.02.2023
//

import SwiftUI

public extension View {
    @available(*, deprecated, renamed: "rowContentMargins")
    func rowContentInset(_ insets: EdgeInsets) -> some View {
        environment(\.rowContentMargins, insets)
    }

    @available(*, deprecated, renamed: "rowContentMargins")
    func rowContentInset(_ insets: CGFloat) -> some View {
        environment(\.rowContentMargins, .init(top: insets, leading: insets, bottom: insets, trailing: insets))
    }
}
