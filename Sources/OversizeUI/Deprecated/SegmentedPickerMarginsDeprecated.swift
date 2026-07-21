//
// Copyright © 2021 Alexander Romanov
// SegmentedPickerMarginsEnvironment.swift, created on 07.02.2023
//

import SwiftUI

public extension View {
    @available(*, deprecated, renamed: "segmentedPickerMargins")
    func segmentedPickerInsets(_ insets: SwiftUI.EdgeInsets) -> some View {
        environment(\.segmentedPickerMargins, SwiftUI.EdgeInsets(
            top: insets.top,
            leading: insets.leading,
            bottom: insets.bottom,
            trailing: insets.trailing
        ))
    }

    @available(*, deprecated, renamed: "segmentedPickerMargins")
    func segmentedPickerInsets(_ insets: Space) -> some View {
        environment(\.segmentedPickerMargins, SwiftUI.EdgeInsets(
            top: insets.rawValue,
            leading: insets.rawValue,
            bottom: insets.rawValue,
            trailing: insets.rawValue
        ))
    }
}
