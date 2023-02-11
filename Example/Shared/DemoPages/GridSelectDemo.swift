//
// Copyright © 2021 Alexander Romanov
// GridSelectDemo.swift, created on 27.11.2022
//

import OversizeUI
import SwiftUI

// swiftlint:disable all
struct GridSelectDemo: View {
    var items = ["One", "Two", "Three", "Four", "One", "Two", "Three", "Four", "One", "Two", "Three", "Four", "One", "Two", "Three", "Four", "One", "Two", "Three", "Four", "One", "Two", "Three", "Four", "One", "Two", "Three", "Four", "One", "Two", "Three", "Four", "One", "Two", "Three", "Four", "One", "Two", "Three", "Four", "One", "Two", "Three", "Four", "One", "Two", "Three", "Four", "One", "Two", "Three", "Four", "One", "Two", "Three", "Four", "One", "Two", "Three", "Four", "One", "Two", "Three", "Four", "One", "Two", "Three", "Four", "One", "Two", "Three", "Four", "One", "Two", "Three", "Four", "One", "Two", "Three", "Four"]
    var items2 = ["One", "Two", "Three", "Four"]

    @State var selection = ""

    var body: some View {
        ScrollView {
            VStack(spacing: .xSmall) {
                ScrollView {
                    GridSelect(items, selection: $selection,
                               content: { item, _ in
                                   VStack {
                                       Icon(.circle)
                                       Text(item)
                                   }.padding()
                               })
                }

                GridSelect(items2, selection: $selection,
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
        .navigationTitle("Grid select")
    }
}

struct GridSelectDemo_Previews: PreviewProvider {
    static var previews: some View {
        GridSelectDemo()
    }
}
