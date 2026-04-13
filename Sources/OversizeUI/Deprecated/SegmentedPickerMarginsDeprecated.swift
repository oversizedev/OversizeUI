//
// Copyright © 2021 Alexander Romanov
// SegmentedPickerMarginsEnvironment.swift, created on 07.02.2023
//

import SwiftUI

public extension View {
    @available(*, deprecated, renamed: "segmentedPickerMargins")
    func segmentedPickerInsets(_ insets: EdgeSpaceInsets) -> some View {
        environment(\.segmentedPickerMargins, EdgeInsets(
            top: insets.top.rawValue,
            leading: insets.leading.rawValue,
            bottom: insets.bottom.rawValue,
            trailing: insets.trailing.rawValue
        ))
    }

    @available(*, deprecated, renamed: "segmentedPickerMargins")
    func segmentedPickerInsets(_ insets: Space) -> some View {
        environment(\.segmentedPickerMargins, EdgeInsets(
            top: insets.rawValue,
            leading: insets.rawValue,
            bottom: insets.rawValue,
            trailing: insets.rawValue
        ))
    }
}
