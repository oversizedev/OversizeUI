//
// Copyright © 2026 Alexander Romanov
// PageIndexDemo.swift, created on 06.09.2026
//

import OversizeUI
import SwiftUI

struct PageIndexDemo: View {
    @State private var index = 0

    private let maxIndex = 4

    var body: some View {
        DemoScreen {
            DemoSectionView("Page index") {
                PageIndexView(index, maxIndex: maxIndex)

                HStack(spacing: .small) {
                    Button("Previous") {
                        index = max(0, index - 1)
                    }
                    .buttonStyle(.tertiary)
                    .accessibilityIdentifier("previousPageButton")

                    Button("Next") {
                        index = min(maxIndex, index + 1)
                    }
                    .buttonStyle(.tertiary)
                    .accessibilityIdentifier("nextPageButton")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        PageIndexDemo()
    }
}
