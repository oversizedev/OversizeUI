//
// Copyright © 2023 Alexander Romanov
// SegmentedPickerInsetsEnvironment.swift
//

import SwiftUI

private struct SegmentedPickerInsetsKey: EnvironmentKey {
    static let defaultValue: EdgeSpaceInsets = .init(top: .xxxSmall, leading: .xxxSmall, bottom: .xxxSmall, trailing: .xxxSmall)
}

public extension EnvironmentValues {
    var segmentedPickerInsets: EdgeSpaceInsets {
        get { self[SegmentedPickerInsetsKey.self] }
        set { self[SegmentedPickerInsetsKey.self] = newValue }
    }
}

public extension View {
    func segmentedPickerInsets(_ insets: EdgeSpaceInsets) -> some View {
        environment(\.segmentedPickerInsets, insets)
    }

    func segmentedPickerInsets(_ insets: Space) -> some View {
        environment(\.segmentedPickerInsets, .init(top: insets, leading: insets, bottom: insets, trailing: insets))
    }
}
