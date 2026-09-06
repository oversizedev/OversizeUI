//
// Copyright © 2026 Alexander Romanov
// PremiumLabelDemo.swift, created on 06.09.2026
//

import OversizeUI
import SwiftUI

struct PremiumLabelDemo: View {
    var body: some View {
        DemoScreen {
            DemoSectionView("Premium label") {
                PremiumLabel()

                PremiumLabel(text: "Pro")
            }
        }
    }
}

#Preview {
    NavigationStack {
        PremiumLabelDemo()
    }
}
