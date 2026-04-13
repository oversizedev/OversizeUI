//
// Copyright © 2021 Alexander Romanov
// SegmentedPickerMarginsEnvironment.swift, created on 07.02.2023
//

import SwiftUI

public extension EnvironmentValues {
    @Entry var segmentedPickerMargins: EdgeInsets = .init(
        top: .small,
        leading: .xxxSmall,
        bottom: .small,
        trailing: .xxxSmall
    )
}

public extension View {
    func segmentedPickerMargins(_ margins: EdgeInsets) -> some View {
        environment(\.segmentedPickerMargins, margins)
    }
}
