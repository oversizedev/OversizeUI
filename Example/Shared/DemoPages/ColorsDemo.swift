//
// Copyright © 2026 Alexander Romanov
// ColorsDemo.swift, created on 06.09.2026
//

import OversizeUI
import SwiftUI

struct ColorsDemo: View {
    private let backgrounds: [(String, Color)] = [
        ("backgroundPrimary", .backgroundPrimary),
        ("backgroundSecondary", .backgroundSecondary),
        ("backgroundTertiary", .backgroundTertiary),
    ]

    private let surfaces: [(String, Color)] = [
        ("surfacePrimary", .surfacePrimary),
        ("surfaceSecondary", .surfaceSecondary),
        ("surfaceTertiary", .surfaceTertiary),
    ]

    private let content: [(String, Color)] = [
        ("onSurfacePrimary", .onSurfacePrimary),
        ("onSurfaceSecondary", .onSurfaceSecondary),
        ("onSurfaceTertiary", .onSurfaceTertiary),
    ]

    private let semantic: [(String, Color)] = [
        ("accent", .accent),
        ("success", .success),
        ("warning", .warning),
        ("error", .error),
        ("link", .link),
        ("border", .border),
    ]

    var body: some View {
        DemoScreen {
            DemoSectionView("Background") {
                swatches(backgrounds)
            }

            DemoSectionView("Surface") {
                swatches(surfaces)
            }

            DemoSectionView("On surface") {
                swatches(content)
            }

            DemoSectionView("Semantic") {
                swatches(semantic)
            }
        }
    }

    private func swatches(_ colors: [(String, Color)]) -> some View {
        ForEach(colors, id: \.0) { name, color in
            HStack(spacing: .small) {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(color)
                    .frame(width: 44, height: 32)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .stroke(Color.border, lineWidth: 1)
                    )

                Text(name)
                    .subheadline()
            }
        }
    }
}

#Preview {
    NavigationStack {
        ColorsDemo()
    }
}
