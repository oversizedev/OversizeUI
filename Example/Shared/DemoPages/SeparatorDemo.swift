//
// Copyright © 2026 Alexander Romanov
// SeparatorDemo.swift, created on 06.09.2026
//

import OversizeUI
import SwiftUI

struct SeparatorDemo: View {
    var body: some View {
        DemoScreen {
            DemoSectionView("Separator") {
                Text("Above")

                Separator()

                Text("Below")
            }
        }
    }
}

#Preview {
    NavigationStack {
        SeparatorDemo()
    }
}
