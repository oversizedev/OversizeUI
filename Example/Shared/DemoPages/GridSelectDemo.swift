//
// Copyright © 2021 Alexander Romanov
// Created on 12.09.2021
//

import OversizeUI
import SwiftUI

struct GridSelectDemo: View {
    var items = ["One", "Two", "Three", "Four"]

    @State var selection = ""

    var body: some View {
        ScrollView {
            VStack(spacing: .xSmall) {
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
        .navigationBarTitle("Grid select", displayMode: .inline)
    }
}

struct GridSelectDemo_Previews: PreviewProvider {
    static var previews: some View {
        GridSelectDemo()
    }
}
