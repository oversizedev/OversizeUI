//
// Copyright © 2021 Alexander Romanov
// SegmentedPickerMarginsEnvironment.swift, created on 07.02.2023
//

import SwiftUI

public extension EnvironmentValues {
    @Entry var segmentedPickerMargins: EdgeSpaceInsets = .init(top: .small, leading: .xxxSmall, bottom: .small, trailing: .xxxSmall)
}

public extension View {
    func segmentedPickerMargins(_ margins: EdgeSpaceInsets) -> some View {
        environment(\.segmentedPickerMargins, margins)
    }

    func segmentedPickerMargins(_ margins: Space) -> some View {
        environment(\.segmentedPickerMargins, .init(top: margins, leading: margins, bottom: margins, trailing: margins))
    }
}
