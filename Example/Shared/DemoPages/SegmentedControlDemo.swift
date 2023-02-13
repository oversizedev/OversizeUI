//
// Copyright © 2021 Alexander Romanov
// SegmentedControlDemo.swift, created on 27.11.2022
//

import OversizeUI
import SwiftUI

struct SegmentedControlDemo: View {
    var items = ["One", "Two", "Three", "Four long"]
    @State var selection = ""

    var body: some View {
        PageView("Segmented control") {
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
                            .subheadline()
                            .onSurfaceHighEmphasisForegroundColor()
                    }
                }
                .segmentedControlStyle(SelectionOnlySegmentedControlStyle())

                VStack {
                    SegmentedPickerSelector(items, selection: $selection) { item, _ in
                        Text(item)
                    }
                    .controlRadius(.small)

                    SegmentedPickerSelector(items, selection: $selection) { item, _ in
                        Text(item)
                    }

                    SegmentedPickerSelector(items, selection: $selection) { item, _ in
                        Text(item)
                    }
                    .controlRadius(.large)

                    SegmentedPickerSelector(items, selection: $selection) { item, _ in
                        Text(item)
                    }
                    .controlRadius(.xLarge)
                }
            }.padding()
        }
        .leadingBar {
            BarButton(.back)
        }
    }
}

struct SegmentedControlDemo_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedControlDemo()
    }
}
