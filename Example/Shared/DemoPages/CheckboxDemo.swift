//
// Copyright © 2026 Alexander Romanov
// CheckboxDemo.swift, created on 06.09.2026
//

import OversizeUI
import SwiftUI

struct CheckboxDemo: View {
    @State private var trailing = true
    @State private var leading = false

    var body: some View {
        DemoScreen {
            DemoSectionView("Alignment") {
                Checkbox("Trailing", isOn: $trailing)
                    .accessibilityIdentifier("trailingCheckbox")

                Checkbox("Leading", isOn: $leading, alignment: .leading)
                    .accessibilityIdentifier("leadingCheckbox")
            }

            DemoSectionView("Custom label") {
                Checkbox(isOn: $trailing, label: {
                    Text("With a view builder label")
                })
            }

            DemoSectionView("Disabled") {
                Checkbox("Disabled on", isOn: .constant(true))
                    .disabled(true)

                Checkbox("Disabled off", isOn: .constant(false))
                    .disabled(true)
            }
        }
    }
}

#Preview {
    NavigationStack {
        CheckboxDemo()
    }
}
