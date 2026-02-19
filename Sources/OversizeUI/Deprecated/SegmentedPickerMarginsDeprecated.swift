//
// Copyright © 2021 Alexander Romanov
// SegmentedPickerMarginsEnvironment.swift, created on 07.02.2023
//

import SwiftUI

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
