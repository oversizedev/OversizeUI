//
// Copyright © 2026 Alexander Romanov
// ListRowDemo.swift, created on 06.09.2026
//

import OversizeUI
import SwiftUI

struct ListRowDemo: View {
    @State private var isOn = true

    var body: some View {
        List {
            Section("Basic") {
                ListRow("Title only")

                ListRow("Title", subtitle: "With subtitle")
            }

            Section("Leading and trailing") {
                ListRow("With icon", leading: {
                    Image.Base.setting.icon()
                })

                ListRow("With toggle", leading: {
                    Image.Base.notification.icon()
                }, trailing: {
                    Toggle("", isOn: $isOn)
                        .labelsHidden()
                        .accessibilityIdentifier("listRowToggle")
                })
            }

            Section("Buttons") {
                ListButton("List button") {}
            }
        }
    }
}

#Preview {
    NavigationStack {
        ListRowDemo()
    }
}
