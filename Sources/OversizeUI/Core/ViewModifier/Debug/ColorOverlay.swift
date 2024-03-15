//
// Copyright © 2023 Alexander Romanov
// DebugOverlayModifier.swift, created on 24.05.2023
//

import SwiftUI

public extension Color {
    static func random(randomOpacity: Bool = false) -> Color {
        Color(
            red: .random(in: 0 ... 1),
            green: .random(in: 0 ... 1),
            blue: .random(in: 0 ... 1),
            opacity: randomOpacity ? .random(in: 0 ... 1) : 1
        )
    }
}

public struct DebugOverlayModifier: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .overlay(Color.random(randomOpacity: true))
    }
}

public extension View {
    func debugOverlay() -> some View {
        modifier(DebugOverlayModifier())
    }
}
