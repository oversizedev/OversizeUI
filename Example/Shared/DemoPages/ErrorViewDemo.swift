//
// Copyright © 2026 Alexander Romanov
// ErrorViewDemo.swift, created on 06.09.2026
//

import OversizeUI
import SwiftUI

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
struct ErrorViewDemo: View {
    private struct DemoError: LocalizedError {
        var errorDescription: String? {
            "Could not load your library"
        }

        var failureReason: String? {
            "The server did not respond."
        }

        var recoverySuggestion: String? {
            "Check your connection and try again."
        }
    }

    var body: some View {
        ErrorView(error: DemoError())
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview {
    NavigationStack {
        ErrorViewDemo()
    }
}
