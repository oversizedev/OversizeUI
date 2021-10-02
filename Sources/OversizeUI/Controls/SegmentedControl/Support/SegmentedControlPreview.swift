//
// Copyright © 2021 Alexander Romanov
// Created on 22.09.2021
//

import SwiftUI

struct SegmentedControlPreview: View {
    var items = ["One", "Two", "Three", "Four long"]

    @State var selection = ""

    var body: some View {
        Group {
            SegmentedPickerSelector(items, selection: $selection) { item, _ in
                Text(item)
            }
            .previewDisplayName("Default")

            SegmentedPickerSelector(items, selection: $selection) { item, _ in
                Text(item)
            }
            .segmentedControlStyle(SelectionOnlySegmentedControlStyle())
            .previewDisplayName("Selection only Style")

            HStack {
                SegmentedPickerSelector(items, selection: $selection) { item, _ in
                    Text(item)
                }
                .segmentedControlStyle(.onlySelection(selected: .accentSurface))

                Spacer()
            }
            .previewLayout(.fixed(width: 375, height: 70))
            .previewDisplayName("Selection only Leading Style")

            HStack {
                SegmentedPickerSelector(items, selection: $selection) { item, _ in
                    Text(item)
                }
                .segmentedControlStyle(ScrollSegmentedControlStyle())
                Spacer()
            }
            .previewLayout(.fixed(width: 375, height: 70))
            .previewDisplayName("Scroll Style")

            HStack {
                SegmentedPickerSelector(items, selection: $selection) { item, _ in
                    Text(item)
                }
                .segmentedControlStyle(.islandScroll(selected: .accentSurface))
                Spacer()
            }
            .previewLayout(.fixed(width: 375, height: 70))
            .previewDisplayName("Scroll Island Style")

            HStack {
                SegmentedPickerSelector(items, selection: $selection) { item, _ in
                    Text(item)
                }
                .segmentedControlStyle(IslandSegmentedControlStyle())
                Spacer()
            }
            .previewLayout(.fixed(width: 375, height: 80))
            .previewDisplayName("Island Style")

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
            .previewDisplayName("Icon and subtitle")

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
            }.previewDisplayName("Radius styles")
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}

// swiftlint:disable all
struct SegmentedPicker2_Preview: PreviewProvider {
    static var previews: some View {
        SegmentedControlPreview()
    }
}
