//
// Copyright © 2021 Alexander Romanov
// SegmentedPickerMarginsEnvironment.swift, created on 07.02.2023
//

import SwiftUI

private struct SegmentedPickerMarginsKey: EnvironmentKey {
    static let defaultValue: EdgeSpaceInsets = .init(top: .small, leading: .xxxSmall, bottom: .small, trailing: .xxxSmall)
}

public extension EnvironmentValues {
    var segmentedPickerMargins: EdgeSpaceInsets {
        get { self[SegmentedPickerMarginsKey.self] }
        set { self[SegmentedPickerMarginsKey.self] = newValue }
    }
}

public extension View {
    func segmentedPickerMargins(_ margins: EdgeSpaceInsets) -> some View {
        environment(\.segmentedPickerMargins, margins)
    }

    func segmentedPickerMargins(_ margins: Space) -> some View {
        environment(\.segmentedPickerMargins, .init(top: margins, leading: margins, bottom: margins, trailing: margins))
    }
}

// MARK: Deprecated methods

public extension View {
    @available(*, deprecated, renamed: "segmentedPickerMargins")
    func segmentedPickerInsets(_ insets: EdgeSpaceInsets) -> some View {
        environment(\.segmentedPickerMargins, insets)
    }

    @available(*, deprecated, renamed: "segmentedPickerMargins")
    func segmentedPickerInsets(_ insets: Space) -> some View {
        environment(\.segmentedPickerMargins, .init(top: insets, leading: insets, bottom: insets, trailing: insets))
    }
}
