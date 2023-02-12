//
// Copyright © 2021 Alexander Romanov
// IconsDemo.swift, created on 27.11.2022
//

import OversizeUI
import SwiftUI

#if os(iOS)
    struct IconsDemo: View {
        let grid = [GridItem(),
                    GridItem(),
                    GridItem(),
                    GridItem(),
                    GridItem(),
                    GridItem()]
        var body: some View {
            PageView("Icons") {
                LazyVGrid(columns: grid) {
                    ForEach(IconsNames.allCases, id: \.self) { icon in
                        Icon(icon)
                            .padding(.vertical)
                    }
                }
                .padding()
            }
            .leadingBar {
                BarButton(.back)
            }
        }
    }

    struct IconsDemo_Previews: PreviewProvider {
        static var previews: some View {
            IconsDemo()
        }
    }
#endif
