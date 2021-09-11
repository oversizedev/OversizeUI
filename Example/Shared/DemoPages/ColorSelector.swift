//
// Copyright © 2021 Alexander Romanov
// Created on 11.09.2021
//

import OversizeUI
import SwiftUI

struct ColorSelector: View {
    @State var colorSelect = Color.red

    var body: some View {
        VStack {
            ColorSelector(colorSelect: colorSelect)

            ColorSelector(colorSelect: colorSelect)
                .colorSelectorStyle(GridColorSelectorStyle())
        }
    }
}

struct ColorSelector_Previews: PreviewProvider {
    static var previews: some View {
        ColorSelector()
    }
}
