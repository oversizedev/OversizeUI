//
// Copyright © 2026 Alexander Romanov
// LoaderDemo.swift, created on 06.09.2026
//

import OversizeUI
import SwiftUI

struct LoaderDemo: View {
    @State private var isLoading = true

    var body: some View {
        DemoScreen {
            #if !os(watchOS)
            DemoSectionView("Spinner") {
                LoaderOverlayView(isLoading: .constant(true))
                    .frame(height: 120)
            }

            DemoSectionView("With text") {
                LoaderOverlayView(showText: true, text: "Loading…", isLoading: .constant(true))
                    .frame(height: 120)
            }
            #endif

            DemoSectionView("Loading modifier") {
                Button("Toggle loading") {
                    isLoading.toggle()
                }
                .buttonStyle(.primary)
                .loading(isLoading)
                .accessibilityIdentifier("loadingButton")
            }
        }
    }
}

#Preview {
    NavigationStack {
        LoaderDemo()
    }
}
