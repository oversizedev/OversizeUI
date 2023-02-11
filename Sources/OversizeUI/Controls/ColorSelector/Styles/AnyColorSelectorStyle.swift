//
// Copyright © 2021 Alexander Romanov
// AnyColorSelectorStyle.swift, created on 02.02.2023
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
