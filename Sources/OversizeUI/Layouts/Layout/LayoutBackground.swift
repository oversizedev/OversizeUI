//
// Copyright © 2026 Alexander Romanov
// LayoutBackground.swift, created on 21.11.2026
//

import SwiftUI

public struct LayoutBackground: View {
    @Environment(\.listLayoutStyle) private var listStyle

    public init() {}

    public var body: some View {
        switch listStyle {
        case .plain:
            Color.backgroundPrimary
        case .inset, .insetGrouped, .smallInsetGrouped, .grouped:
            Color.backgroundSecondary
        }
    }
}

#Preview {
    HStack(spacing: .zero) {
        LayoutBackground()
            .environment(\.listLayoutStyle, .plain)
        LayoutBackground()
            .environment(\.listLayoutStyle, .insetGrouped)
    }
}
