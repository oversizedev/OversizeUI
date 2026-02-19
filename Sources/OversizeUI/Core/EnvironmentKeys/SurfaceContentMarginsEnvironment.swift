//
// Copyright © 2021 Alexander Romanov
// SurfaceContentMarginsEnvironment.swift, created on 07.02.2023
//

import SwiftUI

public extension EnvironmentValues {
    @Entry var surfaceContentMargins: EdgeSpaceInsets = .init(top: .medium, leading: .medium, bottom: .medium, trailing: .medium)
}

public extension View {
    func surfaceContentMargins(_ margins: EdgeSpaceInsets) -> some View {
        environment(\.surfaceContentMargins, margins)
    }

    func surfaceContentMargins(_ margins: Space) -> some View {
        environment(\.surfaceContentMargins, .init(top: margins, leading: margins, bottom: margins, trailing: margins))
    }

    func surfaceContentRowMargins() -> some View {
        #if os(macOS)
        environment(\.surfaceContentMargins, .init(top: .xxxSmall, leading: .zero, bottom: .xxxSmall, trailing: .zero))
        #else
        environment(\.surfaceContentMargins, .init(top: .xxSmall, leading: .zero, bottom: .xxSmall, trailing: .zero))
        #endif
    }
}

