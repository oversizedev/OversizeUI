//
// Copyright © 2026 Alexander Romanov
// ListLayoutDemo.swift, created on 06.09.2026
//

import OversizeUI
import SwiftUI

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, *)
struct ListLayoutDemo: View {
    var body: some View {
        ListLayout {
            ListSection("Section") {
                ForEach(1 ... 5, id: \.self) { index in
                    ListRow("Item \(index)")
                }
            }

            ListSection {
                ForEach(6 ... 10, id: \.self) { index in
                    ListRow("Item \(index)")
                }
            } footer: {
                ListSectionFooter(description: "A footer describing the section above.")
            }
        }
        .listLayoutStyle(.insetGrouped)
    }
}

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, *)
#Preview {
    NavigationStack {
        ListLayoutDemo()
    }
}
