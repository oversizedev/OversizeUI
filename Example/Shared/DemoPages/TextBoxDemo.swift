//
// Copyright © 2026 Alexander Romanov
// TextBoxDemo.swift, created on 06.09.2026
//

import OversizeUI
import SwiftUI

struct TextBoxDemo: View {
    var body: some View {
        DemoScreen {
            DemoSectionView("Text box") {
                TextBox(title: "Title only")

                TextBox(title: "Title", subtitle: "With a supporting subtitle")

                TextBox(title: "Compact", subtitle: "Custom spacing", spacing: .xxSmall)
            }
        }
    }
}

#Preview {
    NavigationStack {
        TextBoxDemo()
    }
}
