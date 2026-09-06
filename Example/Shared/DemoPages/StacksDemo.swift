//
// Copyright © 2026 Alexander Romanov
// StacksDemo.swift, created on 06.09.2026
//

import OversizeUI
import SwiftUI

struct StacksDemo: View {
    var body: some View {
        DemoScreen {
            DemoSectionView("Leading") {
                LeadingVStack(spacing: .xxSmall) {
                    Text("First")
                    Text("Second")
                }
            }

            DemoSectionView("Center") {
                CenterVStack(spacing: .xxSmall) {
                    Text("First")
                    Text("Second")
                }
            }

            DemoSectionView("Trailing") {
                TrailingVStack(spacing: .xxSmall) {
                    Text("First")
                    Text("Second")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        StacksDemo()
    }
}
