//
// Copyright © 2021 Alexander Romanov
// ButtonsDemo.swift, created on 27.11.2022
//

import OversizeUI
import SwiftUI

struct ButtonsDemo: View {
    var body: some View {
        DemoScreen {
            DemoSectionView("Styles") {
                Button("Primary") {}
                    .buttonStyle(.primary)

                Button("Secondary") {}
                    .buttonStyle(.secondary)

                Button("Tertiary") {}
                    .buttonStyle(.tertiary)

                Button("Quaternary") {}
                    .buttonStyle(.quaternary)
            }

            DemoSectionView("Accent") {
                Button("Accent primary") {}
                    .buttonStyle(.primary)
                    .accent()

                Button("Accent quaternary") {}
                    .buttonStyle(.quaternary)
                    .accent()
            }

            DemoSectionView("Roles") {
                Button(role: .cancel) {} label: {
                    Text("Cancel")
                }
                .buttonStyle(.primary)

                Button(role: .destructive) {} label: {
                    Text("Destructive")
                }
                .buttonStyle(.primary)
            }

            DemoSectionView("Radius and elevation") {
                Button("Extra large radius") {}
                    .buttonStyle(.primary)
                    .controlRadius(.xLarge)

                Button("Elevated") {}
                    .buttonStyle(.secondary)
                    .elevation(.z2)
            }

            #if os(iOS) || os(macOS) || os(watchOS)
            DemoSectionView("Control sizes") {
                Button("Small") {}
                    .buttonStyle(.secondary)
                    .controlSize(.small)

                Button("Mini") {}
                    .buttonStyle(.secondary)
                    .controlSize(.mini)
            }
            #endif
        }
    }
}

#Preview {
    NavigationStack {
        ButtonsDemo()
    }
}
