//
// Copyright © 2021 Alexander Romanov
// ColorSelector.swift, created on 27.11.2022
//

import OversizeUI
import SwiftUI

struct ColorSelect: View {
    @State var colorSelect = Color.red

    @State var colorSelect2 = Color.red

    var body: some View {
        VStack {
            ColorSelector(selection: $colorSelect)

            ColorSelector(selection: $colorSelect2)
                .colorSelectorStyle(GridColorSelectorStyle())
        }
        .navigationTitle("Color select")
    }
}

struct ColorSelect_Previews: PreviewProvider {
    static var previews: some View {
        ColorSelect()
    }
}
