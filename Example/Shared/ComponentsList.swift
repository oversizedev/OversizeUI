//
// Copyright © 2021 Alexander Romanov
// ComponentsList.swift, created on 27.11.2022
//

import OversizeUI
import SwiftUI

struct ComponentsList: View {
    var body: some View {
        if #available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, *) {
            Layout("OversizeUI") {
                ForEach(Demos.sections) { section in
                    Section(section.title) {
                        ForEach(section.demos) { demo in
                            NavigationLink {
                                demo.screen
                                    .navigationTitle(demo.title)
                            } label: {
                                Row(demo.title)
                            }
                            .buttonStyle(.row)
                            .accessibilityIdentifier(demo.title)
                        }
                    }
                }
            }
            .listLayoutStyle(.insetGrouped)
            .sectionTitlePosition(.outside)
        } else {
            unavailableView
        }
    }

    private var unavailableView: some View {
        VStack(spacing: .small) {
            Text("Requires a newer OS")
                .title3(.semibold)

            Text("The component gallery uses the Layout system, which needs iOS 18, macOS 15, tvOS 18 or watchOS 11.")
                .body()
                .multilineTextAlignment(.center)
                .onSurfaceSecondary()
        }
        .padding()
    }
}

#Preview {
    NavigationStack {
        ComponentsList()
    }
}
