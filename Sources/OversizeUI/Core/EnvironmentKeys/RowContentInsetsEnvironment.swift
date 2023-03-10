//
// Copyright © 2021 Alexander Romanov
// RowContentInsetsEnvironment.swift, created on 07.02.2023
//

import SwiftUI

private struct RowContentInsetsKey: EnvironmentKey {
    static let defaultValue: EdgeSpaceInsets = .init(top: .small, leading: .medium, bottom: .small, trailing: .medium)
}

public extension EnvironmentValues {
    var rowContentInset: EdgeSpaceInsets {
        get { self[RowContentInsetsKey.self] }
        set { self[RowContentInsetsKey.self] = newValue }
    }
}

public extension View {
    func rowContentInset(_ insets: EdgeSpaceInsets) -> some View {
        environment(\.rowContentInset, insets)
    }

    func rowContentInset(_ insets: Space) -> some View {
        environment(\.rowContentInset, .init(top: insets, leading: insets, bottom: insets, trailing: insets))
    }
}
