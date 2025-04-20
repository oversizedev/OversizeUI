//
// Copyright © 2021 Alexander Romanov
// SurfaceContentMarginsEnvironment.swift, created on 07.02.2023
//

import SwiftUI

private struct SurfaceContentMarginsKey: EnvironmentKey {
    static let defaultValue: EdgeSpaceInsets = .init(top: .medium, leading: .medium, bottom: .medium, trailing: .medium)
}

public extension EnvironmentValues {
    var surfaceContentMargins: EdgeSpaceInsets {
        get { self[SurfaceContentMarginsKey.self] }
        set { self[SurfaceContentMarginsKey.self] = newValue }
    }
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

// MARK: Deprecated methods

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
