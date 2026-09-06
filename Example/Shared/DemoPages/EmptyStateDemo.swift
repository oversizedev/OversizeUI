//
// Copyright © 2026 Alexander Romanov
// EmptyStateDemo.swift, created on 06.09.2026
//

import OversizeUI
import SwiftUI

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
struct EmptyStateDemo: View {
    var body: some View {
        EmptyStateView(
            image: Image.Base.search,
            title: "Nothing here yet",
            subtitle: "Items you add will show up in this list"
        ) {
            Button("Add item") {}
                .accessibilityIdentifier("emptyStateAction")
        }
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview {
    NavigationStack {
        EmptyStateDemo()
    }
}
