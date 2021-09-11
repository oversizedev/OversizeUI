//
// Copyright © 2021 Alexander Romanov
// Created on 11.09.2021
//

import OversizeUI
import SwiftUI

struct GridSelectDemo: View {
    var items = ["One", "Two", "Three", "Four"]

    @State var selection = ""

    var body: some View {
        Group {
            GridSelect(items, selection: $selection,
                       content: { item, _ in
                           VStack {
                               Icon(.circle)
                               Text(item)
                           }.padding()
                       })

            GridSelect(items, selection: $selection,
                       content: { item, _ in
                           VStack {
                               Icon(.circle)
                               Text(item)
                           }.padding()
                       })

                .gridSelectStyle(SelectionOnlyGridSelectStyle())
        }
        .padding()
    }
}

struct GridSelectDemo_Previews: PreviewProvider {
    static var previews: some View {
        GridSelectDemo()
    }
}
