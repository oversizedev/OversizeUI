//
// Copyright © 2021 Alexander Romanov
// BarButtonMenuStyle.swift, created on 02.02.2023
//

import SwiftUI

@available(watchOS, unavailable)
public struct BarButtonMenuStyle: MenuStyle {
    @Environment(\.theme) private var theme: ThemeSettings
    @Environment(\.isBordered) var isBordered: Bool

    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        Menu(configuration)
            .body(true)
            .foregroundColor(Color.onPrimaryHighEmphasis)
            .padding(.xxSmall)
            .background(background)
            .shadowElevaton(.z2)
    }

    private var background: some View {
        Capsule()
            .fill(Color.surfacePrimary)
            .overlay {
                Capsule()
                    .strokeBorder(Color.onSurfaceHighEmphasis.opacity(0.15), lineWidth: 2)
                    .opacity(isBordered || theme.borderButtons ? 1 : 0)
            }
    }
}

@available(watchOS, unavailable)
public extension MenuStyle where Self == BarButtonMenuStyle {
    static var barButton: BarButtonMenuStyle {
        BarButtonMenuStyle()
    }
}
