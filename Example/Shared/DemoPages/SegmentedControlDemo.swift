//
// Copyright © 2021 Alexander Romanov
// Created on 12.09.2021
//

import OversizeUI
import SwiftUI

struct SegmentedControlDemo: View {
    var items = ["One", "Two", "Three", "Four long"]
    @State var selection = ""

    var body: some View {
        ScrollView {
            VStack(spacing: .xSmall) {
                SegmentedPickerSelector(items, selection: $selection) { item, _ in
                    Text(item)
                }

                SegmentedPickerSelector(items, selection: $selection) { item, _ in
                    Text(item)
                }
                .segmentedControlStyle(SelectionOnlySegmentedControlStyle())

                HStack {
                    SegmentedPickerSelector(items, selection: $selection) { item, _ in
                        Text(item)
                    }
                    .segmentedControlStyle(.onlySelection(selected: .accentSurface))

                    Spacer()
                }

                HStack {
                    SegmentedPickerSelector(items, selection: $selection) { item, _ in
                        Text(item)
                    }
                    .segmentedControlStyle(ScrollSegmentedControlStyle())
                    Spacer()
                }

                HStack {
                    SegmentedPickerSelector(items, selection: $selection) { item, _ in
                        Text(item)
                    }
                    .segmentedControlStyle(.islandScroll(selected: .accentSurface))
                    Spacer()
                }

                HStack {
                    SegmentedPickerSelector(items, selection: $selection) { item, _ in
                        Text(item)
                    }
                    .segmentedControlStyle(IslandSegmentedControlStyle())
                    Spacer()
                }

                SegmentedPickerSelector(items, selection: $selection) { item, _ in
                    VStack(spacing: Space.xxxSmall.rawValue) {
                        Icon(.circle)
                            .padding(.xxSmall)
                        Text(item)
                        Text("Subtitle")
                            .fontStyle(.subtitle2, color: .onSurfaceMediumEmphasis)
                    }
                }
                .segmentedControlStyle(SelectionOnlySegmentedControlStyle())

                VStack {
                    SegmentedPickerSelector(items, selection: $selection, radius: .small) { item, _ in
                        Text(item)
                    }

                    SegmentedPickerSelector(items, selection: $selection) { item, _ in
                        Text(item)
                    }

                    SegmentedPickerSelector(items, selection: $selection, radius: .large) { item, _ in
                        Text(item)
                    }

                    SegmentedPickerSelector(items, selection: $selection, radius: .xLarge) { item, _ in
                        Text(item)
                    }
                }
            }.padding()
        }.navigationBarTitle("Segmented control", displayMode: .inline)
    }
}

struct SegmentedControlDemo_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedControlDemo()
    }
}
