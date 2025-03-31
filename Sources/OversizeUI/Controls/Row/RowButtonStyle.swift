//
// Copyright © 2021 Alexander Romanov
// RowButtonStyle.swift, created on 18.12.2022
//

import SwiftUI

public struct RowActionButtonStyle: ButtonStyle {
    public init() {}
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? Color.backgroundSecondary.opacity(0.7) : Color.clear)
            .contentShape(Rectangle())
    }
}

public extension ButtonStyle where Self == RowActionButtonStyle {
    static var row: RowActionButtonStyle {
        RowActionButtonStyle()
    }
}
