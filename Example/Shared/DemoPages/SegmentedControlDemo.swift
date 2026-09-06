//
// Copyright © 2021 Alexander Romanov
// SegmentedControlDemo.swift, created on 27.11.2022
//

import OversizeUI
import SwiftUI

struct SegmentedControlDemo: View {
    private let items = ["One", "Two", "Three", "Four long"]

    @State private var selection = "One"

    var body: some View {
        DemoScreen {
            DemoSectionView("Default") {
                SegmentedPickerSelector(items, selection: $selection) { item, _ in
                    Text(item)
                }
                .accessibilityIdentifier("defaultSegmentedControl")
            }

            DemoSectionView("Selection only") {
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
            }

            DemoSectionView("Scroll") {
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
            }

            DemoSectionView("Island") {
                HStack {
                    SegmentedPickerSelector(items, selection: $selection) { item, _ in
                        Text(item)
                    }
                    .segmentedControlStyle(IslandSegmentedControlStyle())

                    Spacer()
                }
            }

            DemoSectionView("Icon and subtitle") {
                SegmentedPickerSelector(items, selection: $selection) { item, _ in
                    VStack(spacing: Space.xxxSmall.rawValue) {
                        Icon(Image.Base.category)
                            .padding(.xxSmall)

                        Text(item)

                        Text("Subtitle")
                            .subheadline()
                            .onSurfaceSecondary()
                    }
                }
                .segmentedControlStyle(SelectionOnlySegmentedControlStyle())
            }

            DemoSectionView("Radius") {
                SegmentedPickerSelector(items, selection: $selection) { item, _ in
                    Text(item)
                }
                .controlRadius(.small)

                SegmentedPickerSelector(items, selection: $selection) { item, _ in
                    Text(item)
                }
                .controlRadius(.large)

                SegmentedPickerSelector(items, selection: $selection) { item, _ in
                    Text(item)
                }
                .controlRadius(.xLarge)
            }
        }
    }
}

#Preview {
    NavigationStack {
        SegmentedControlDemo()
    }
}
