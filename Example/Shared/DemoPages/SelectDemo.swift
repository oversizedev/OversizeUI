//
// Copyright © 2021 Alexander Romanov
// SelectDemo.swift, created on 27.11.2022
//

import OversizeUI
import SwiftUI

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
struct SelectDemo: View {
    private let items = ["One", "Two", "Three", "Four"]

    @State private var selection = "One"

    var body: some View {
        DemoScreen {
            DemoSectionView("Select") {
                Select("Select", items, selection: $selection) { item, isSelected in
                    Radio(item, isOn: isSelected)
                } selectionView: { selected in
                    Text(selected)
                }
                .accessibilityIdentifier("selectField")
            }
        }
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview {
    NavigationStack {
        SelectDemo()
    }
}
