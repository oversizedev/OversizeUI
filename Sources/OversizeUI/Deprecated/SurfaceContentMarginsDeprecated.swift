//
// Copyright © 2021 Alexander Romanov
// SurfaceContentMarginsEnvironment.swift, created on 07.02.2023
//

import SwiftUI

public extension View {
    @available(*, deprecated, renamed: "surfaceContentMargins")
    func surfaceContentInsets(_ insets: EdgeSpaceInsets) -> some View {
        environment(\.surfaceContentMargins, insets)
    }

    @available(*, deprecated, renamed: "surfaceContentMargins")
    func surfaceContentInsets(_ insets: Space) -> some View {
        environment(\.surfaceContentMargins, .init(top: insets, leading: insets, bottom: insets, trailing: insets))
    }

    @available(*, deprecated, renamed: "surfaceContentRowMargins")
    func surfaceContentRowInsets() -> some View {
        environment(\.surfaceContentMargins, .init(top: .xxSmall, leading: .zero, bottom: .xxSmall, trailing: .zero))
    }
}
