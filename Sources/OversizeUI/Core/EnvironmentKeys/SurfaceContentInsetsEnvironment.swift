//
// Copyright © 2021 Alexander Romanov
// SurfaceContentInsetsEnvironment.swift, created on 07.02.2023
//

import SwiftUI

private struct SurfaceContentInsetsKey: EnvironmentKey {
    static let defaultValue: EdgeSpaceInsets = .init(top: .zero, leading: .zero, bottom: .zero, trailing: .zero)
}

public extension EnvironmentValues {
    var surfaceContentInsets: EdgeSpaceInsets {
        get { self[SurfaceContentInsetsKey.self] }
        set { self[SurfaceContentInsetsKey.self] = newValue }
    }
}

public extension View {
    func surfaceContentInsets(_ insets: EdgeSpaceInsets) -> some View {
        environment(\.surfaceContentInsets, insets)
    }

    func surfaceContentInsets(_ insets: Space) -> some View {
        environment(\.surfaceContentInsets, .init(top: insets, leading: insets, bottom: insets, trailing: insets))
    }

    func surfaceContentRowInsets() -> some View {
        environment(\.surfaceContentInsets, .init(top: .xxSmall, leading: .zero, bottom: .xxSmall, trailing: .zero))
    }
}
