//
// Copyright © 2026 Alexander Romanov
// RadioDemo.swift, created on 06.09.2026
//

import OversizeUI
import SwiftUI

struct RadioDemo: View {
    private let items = ["One", "Two", "Three"]

    @State private var selection = "One"

    var body: some View {
        DemoScreen {
            DemoSectionView("Radio") {
                Radio("Selected", isOn: true)

                Radio("Not selected", isOn: false)

                Radio("Leading", isOn: true, alignment: .leading)
            }

            DemoSectionView("RadioPicker") {
                RadioPicker(items, selection: $selection) { item in
                    Text(item)
                }
                .accessibilityIdentifier("radioPicker")
            }
        }
    }
}

#Preview {
    NavigationStack {
        RadioDemo()
    }
}
