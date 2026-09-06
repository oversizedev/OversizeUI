//
// Copyright © 2026 Alexander Romanov
// CoverLayoutDemo.swift, created on 06.09.2026
//

import OversizeUI
import SwiftUI

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, *)
struct CoverLayoutDemo: View {
    var body: some View {
        CoverLayout("Album") {
            Section("Tracks") {
                ForEach(1 ... 12, id: \.self) { index in
                    Row("Track \(index)")
                }
            }
        } cover: {
            LinearGradient(
                colors: [.accent, .backgroundSecondary],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
}

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, *)
#Preview {
    NavigationStack {
        CoverLayoutDemo()
    }
}
