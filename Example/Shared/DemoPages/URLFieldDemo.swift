//
// Copyright © 2026 Alexander Romanov
// URLFieldDemo.swift, created on 06.09.2026
//

import OversizeUI
import SwiftUI

#if os(iOS) || os(macOS)
@available(iOS 15.0, macOS 14.0, *)
struct URLFieldDemo: View {
    @State private var url: URL?

    var body: some View {
        DemoScreen {
            DemoSectionView("URL field") {
                URLField(url: $url)
                    .accessibilityIdentifier("urlField")
            }
        }
    }
}

@available(iOS 15.0, macOS 14.0, *)
#Preview {
    NavigationStack {
        URLFieldDemo()
    }
}
#endif
