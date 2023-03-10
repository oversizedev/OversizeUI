//
// Copyright © 2021 Alexander Romanov
// ScaleButton.swift, created on 19.11.2022
//

import SwiftUI

public struct ScaleButtonStyle: ButtonStyle {
    public init() {}

    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.96 : 1)
            .animation(.easeIn(duration: 0.2), value: configuration.isPressed)
    }
}

public extension ButtonStyle where Self == ScaleButtonStyle {
    static var scale: ScaleButtonStyle {
        ScaleButtonStyle()
    }
}
