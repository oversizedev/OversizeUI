//
// Copyright © 2021 Alexander Romanov
// Created on 11.09.2021
//

import OversizeUI
import SwiftUI

struct IconsDemo: View {
    let grid = [GridItem(),
                GridItem(),
                GridItem(),
                GridItem(),
                GridItem(),
                GridItem()]
    var body: some View {
        LazyVGrid(columns: grid) {
            ForEach(Icons.allCases, id: \.self) { icon in
                Icon(icon)
                    .padding(.vertical)
            }
        }
        .padding()
    }
}

struct IconsDemo_Previews: PreviewProvider {
    static var previews: some View {
        IconsDemo()
    }
}
