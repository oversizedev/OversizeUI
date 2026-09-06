//
// Copyright © 2021 Alexander Romanov
// RowDemo.swift, created on 27.11.2022
//

import OversizeUI
import SwiftUI

struct RowDemo: View {
    @State private var isOn = true

    var body: some View {
        DemoScreen {
            DemoSectionView("Basic") {
                Row("Title only")

                Row("Title", subtitle: "With a supporting subtitle")
            }

            DemoSectionView("Leading and trailing") {
                Row("With leading icon") {
                    Icon(Image.Base.setting)
                }

                Row("With toggle") {
                    Icon(Image.Base.notification)
                } trailing: {
                    Toggle("", isOn: $isOn)
                        .labelsHidden()
                        .accessibilityIdentifier("rowToggle")
                }
            }

            DemoSectionView("Navigatable") {
                Row("Tappable row", subtitle: "Shows a chevron") {}
                    .navigatable()
            }
        }
    }
}

#Preview {
    NavigationStack {
        RowDemo()
    }
}
