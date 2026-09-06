//
// Copyright © 2026 Alexander Romanov
// ContentViewDemo.swift, created on 06.09.2026
//

import OversizeUI
import SwiftUI

struct ContentViewDemo: View {
    var body: some View {
        DemoScreen {
            DemoSectionView("Title only") {
                ContentView(title: "All caught up")
            }

            DemoSectionView("With actions") {
                ContentView(
                    image: Image.Base.check,
                    title: "Subscription activated",
                    subtitle: "You now have access to every feature"
                ) {
                    Button("Continue") {}
                        .buttonStyle(.primary)
                        .accent()

                    Button("Not now") {}
                        .buttonStyle(.tertiary)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ContentViewDemo()
    }
}
