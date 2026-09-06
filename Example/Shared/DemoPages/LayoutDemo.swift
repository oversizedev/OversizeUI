//
// Copyright © 2026 Alexander Romanov
// LayoutDemo.swift, created on 06.09.2026
//

import OversizeUI
import SwiftUI

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, *)
struct LayoutDemo: View {
    @State private var style: ListLayoutStyle = .insetGrouped

    var body: some View {
        Layout("Layout") {
            Section("Title inside") {
                Row("First")
                Row("Second")
                Row("Third")
            }
            .sectionTitlePosition(.inside)

            Section("Title outside") {
                Row("First")
                Row("Second")
            }
            .sectionTitlePosition(.outside)

            Section {
                Row("Content")
            } header: {
                Text("Custom header")
            } footer: {
                Text("Custom footer explains the section")
            }

            Section("Dotted background") {
                Button("Create a new group") {}
                    .accessibilityIdentifier("dottedSectionButton")
            }
            .sectionBackgroundStyle(.dotted)

            Section("Style") {
                Button("Plain") { style = .plain }
                Button("Inset") { style = .inset }
                Button("Inset grouped") { style = .insetGrouped }
                Button("Small inset grouped") { style = .smallInsetGrouped }
                Button("Grouped") { style = .grouped }
            }
        }
        .listLayoutStyle(style)
        .sectionTitleSeparator(.visible)
        .bordered()
    }
}

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, *)
#Preview {
    NavigationStack {
        LayoutDemo()
    }
}
