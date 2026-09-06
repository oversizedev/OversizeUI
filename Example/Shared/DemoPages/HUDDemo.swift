//
// Copyright © 2026 Alexander Romanov
// HUDDemo.swift, created on 06.09.2026
//

import OversizeUI
import SwiftUI

struct HUDDemo: View {
    @State private var isPresented = false

    var body: some View {
        DemoScreen {
            DemoSectionView("HUD") {
                Button("Show HUD") {
                    isPresented = true
                }
                .buttonStyle(.primary)
                .accessibilityIdentifier("showHUDButton")

                HUD("Copied", autoHide: false, isPresented: .constant(true)) {
                    Icon(Image.Base.check)
                }
            }
        }
        .hud("Copied to clipboard", isPresented: $isPresented)
    }
}

#Preview {
    NavigationStack {
        HUDDemo()
    }
}
