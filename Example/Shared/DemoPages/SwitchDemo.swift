//
// Copyright © 2026 Alexander Romanov
// SwitchDemo.swift, created on 06.09.2026
//

import OversizeUI
import SwiftUI

struct SwitchDemo: View {
    @State private var trailing = true
    @State private var leading = false
    @State private var withSubtitle = true

    var body: some View {
        DemoScreen {
            DemoSectionView("Alignment") {
                Switch("Trailing", isOn: $trailing)
                    .accessibilityIdentifier("trailingSwitch")

                Switch("Leading", isOn: $leading, alignment: .leading)
                    .accessibilityIdentifier("leadingSwitch")
            }

            DemoSectionView("Subtitle") {
                Switch("Notifications", subtitle: "Receive push notifications", isOn: $withSubtitle)
            }

            DemoSectionView("Disabled") {
                Switch("Disabled", isOn: .constant(true))
                    .disabled(true)
            }
        }
    }
}

#Preview {
    NavigationStack {
        SwitchDemo()
    }
}
