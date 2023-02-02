//
// Copyright © 2023 Alexander Romanov
// AnyColorSelectorStyle.swift
//

import SwiftUI

public struct AnyColorSelectorStyle: ColorSelectorStyle {
    private var _makeBody: (Configuration) -> AnyView

    public init(style: some ColorSelectorStyle) {
        _makeBody = { configuration in
            AnyView(style.makeBody(configuration: configuration))
        }
    }

    public func makeBody(configuration: Configuration) -> some View {
        _makeBody(configuration)
    }
}
