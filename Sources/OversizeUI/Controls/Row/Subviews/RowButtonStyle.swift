//
// Copyright © 2022 Alexander Romanov
// RowButtonStyle.swift
//

import SwiftUI

public struct RowActionButtonStyle: ButtonStyle {
    public init() {}
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? Color.surfaceSecondary : Color.clear)
            .contentShape(Rectangle())
    }
}

public extension ButtonStyle where Self == RowActionButtonStyle {
    static var row: RowActionButtonStyle {
        RowActionButtonStyle()
    }
}
