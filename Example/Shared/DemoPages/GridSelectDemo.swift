//
// Copyright © 2021 Alexander Romanov
// GridSelectDemo.swift, created on 27.11.2022
//

import OversizeUI
import SwiftUI

struct GridSelectDemo: View {
    private let items = ["Swift", "SwiftUI", "Xcode", "iOS"]

    @State private var defaultSelection = "Swift"
    @State private var selectionOnly = "Swift"

    var body: some View {
        DemoScreen {
            DemoSectionView("Default") {
                GridSelect(items, selection: $defaultSelection) { item, _ in
                    VStack(spacing: .xxSmall) {
                        Icon(Image.Base.category)

                        Text(item)
                    }
                    .padding()
                }
                .accessibilityIdentifier("defaultGridSelect")
            }

            DemoSectionView("Selection only") {
                GridSelect(items, selection: $selectionOnly) { item, _ in
                    VStack(spacing: .xxSmall) {
                        Icon(Image.Base.star)

                        Text(item)
                    }
                    .padding()
                }
                .gridSelectStyle(SelectionOnlyGridSelectStyle())
            }
        }
    }
}

#Preview {
    NavigationStack {
        GridSelectDemo()
    }
}
