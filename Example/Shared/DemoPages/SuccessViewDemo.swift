//
// Copyright © 2026 Alexander Romanov
// SuccessViewDemo.swift, created on 06.09.2026
//

import OversizeUI
import SwiftUI

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
struct SuccessViewDemo: View {
    var body: some View {
        SuccessView(
            title: "All done",
            subtitle: "Your changes have been saved"
        ) {
            Button("Continue") {}
                .accessibilityIdentifier("successAction")
        }
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview {
    NavigationStack {
        SuccessViewDemo()
    }
}
