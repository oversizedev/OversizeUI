//
// Copyright © 2026 Alexander Romanov
// SpacingDemo.swift, created on 06.09.2026
//

import OversizeUI
import SwiftUI

struct SpacingDemo: View {
    private let spaces: [(String, Space)] = [
        ("xxxSmall", .xxxSmall),
        ("xxSmall", .xxSmall),
        ("xSmall", .xSmall),
        ("small", .small),
        ("regular", .regular),
        ("medium", .medium),
        ("large", .large),
        ("xLarge", .xLarge),
        ("xxLarge", .xxLarge),
        ("xxxLarge", .xxxLarge),
    ]

    var body: some View {
        DemoScreen {
            DemoSectionView("Scale") {
                ForEach(spaces, id: \.0) { name, space in
                    HStack(spacing: .small) {
                        RoundedRectangle(cornerRadius: 4, style: .continuous)
                            .fill(Color.accent)
                            .frame(width: space.rawValue, height: 16)

                        Text("\(name) — \(Int(space.rawValue))pt")
                            .subheadline()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SpacingDemo()
    }
}
