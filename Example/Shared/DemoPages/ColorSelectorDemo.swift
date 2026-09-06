//
// Copyright © 2021 Alexander Romanov
// ColorSelectorDemo.swift, created on 27.11.2022
//

import OversizeUI
import SwiftUI

#if !os(watchOS) && !os(tvOS)
struct ColorSelectorDemo: View {
    @State private var horizontalColor: Color = .red
    @State private var gridColor: Color = .blue

    var body: some View {
        DemoScreen {
            DemoSectionView("Horizontal") {
                ColorSelector(selection: $horizontalColor)
                    .colorSelectorStyle(HorizontalColorSelectorStyle())
            }

            DemoSectionView("Grid") {
                ColorSelector(selection: $gridColor)
                    .colorSelectorStyle(GridColorSelectorStyle())
            }
        }
    }
}

#Preview {
    NavigationStack {
        ColorSelectorDemo()
    }
}
#endif
