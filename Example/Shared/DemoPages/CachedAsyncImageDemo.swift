//
// Copyright © 2026 Alexander Romanov
// CachedAsyncImageDemo.swift, created on 06.09.2026
//

import OversizeUI
import SwiftUI

struct CachedAsyncImageDemo: View {
    private let url = URL(string: "https://avatars.githubusercontent.com/u/23033825")

    var body: some View {
        DemoScreen {
            DemoSectionView("Cached async image") {
                CachedAsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 120, height: 120)
                .clipShape(Circle())
                .accessibilityIdentifier("cachedImage")
            }
        }
    }
}

#Preview {
    NavigationStack {
        CachedAsyncImageDemo()
    }
}
