//
// Copyright © 2023 Alexander Romanov
// RowContentInsetsEnvironment.swift
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
