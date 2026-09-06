//
// Copyright © 2021 Alexander Romanov
// SegmentedControlPreview.swift, created on 11.09.2021
//

import SwiftUI

private struct SegmentedControlPreview<Content: View>: View {
    let items = ["One", "Two", "Three", "Four long"]

    @State private var selection = ""

    @ViewBuilder private let content: (String, Bool) -> Content

    init(@ViewBuilder content: @escaping (String, Bool) -> Content) {
        self.content = content
    }

    var body: some View {
        SegmentedPickerSelector(items, selection: $selection, content: content)
            .padding()
    }
}

private struct TitleSegmentedControlPreview: View {
    var body: some View {
        SegmentedControlPreview { item, _ in
            Text(item)
        }
    }
}

#Preview("Default") {
    TitleSegmentedControlPreview()
}

#Preview("Selection only") {
    TitleSegmentedControlPreview()
        .segmentedControlStyle(SelectionOnlySegmentedControlStyle())
}

#Preview("Selection only leading") {
    HStack {
        TitleSegmentedControlPreview()
            .segmentedControlStyle(.onlySelection(selected: .accentSurface))

        Spacer()
    }
}

#Preview("Scroll") {
    HStack {
        TitleSegmentedControlPreview()
            .segmentedControlStyle(ScrollSegmentedControlStyle())

        Spacer()
    }
}

#Preview("Scroll island") {
    HStack {
        TitleSegmentedControlPreview()
            .segmentedControlStyle(.islandScroll(selected: .accentSurface))

        Spacer()
    }
}

#Preview("Island") {
    HStack {
        TitleSegmentedControlPreview()
            .segmentedControlStyle(IslandSegmentedControlStyle())

        Spacer()
    }
}

#Preview("Icon and subtitle") {
    SegmentedControlPreview { item, _ in
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

#Preview("Radius styles") {
    VStack {
        TitleSegmentedControlPreview()
            .controlRadius(.small)

        TitleSegmentedControlPreview()

        TitleSegmentedControlPreview()
            .controlRadius(.large)

        TitleSegmentedControlPreview()
            .controlRadius(.xLarge)
    }
}
