//
// Copyright © 2021 Alexander Romanov
// IconStyleEnvironment.swift, created on 06.09.2022
//

import SwiftUI

public enum IconStyle: Sendable {
    case line, fill, twoTone
}

public extension EnvironmentValues {
    @Entry var iconStyle: IconStyle = .line
}

public extension View {
    func iconStyle(_ iconStyle: IconStyle) -> some View {
        environment(\.iconStyle, iconStyle)
    }
}
