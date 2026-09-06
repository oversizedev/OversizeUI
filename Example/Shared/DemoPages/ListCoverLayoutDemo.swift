//
// Copyright © 2026 Alexander Romanov
// ListCoverLayoutDemo.swift, created on 06.09.2026
//

import OversizeUI
import SwiftUI

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, *)
struct ListCoverLayoutDemo: View {
    var body: some View {
        ListCoverLayout("Playlist") {
            ListSection("Tracks") {
                ForEach(1 ... 20, id: \.self) { index in
                    ListRow("Track \(index)")
                }
            }
        } cover: {
            LinearGradient(
                colors: [.accent, .backgroundSecondary],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }
}

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, *)
#Preview {
    NavigationStack {
        ListCoverLayoutDemo()
    }
}
