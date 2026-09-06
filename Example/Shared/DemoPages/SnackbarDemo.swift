//
// Copyright © 2026 Alexander Romanov
// SnackbarDemo.swift, created on 06.09.2026
//

import OversizeUI
import SwiftUI

struct SnackbarDemo: View {
    @State private var isPresented = true

    var body: some View {
        DemoScreen {
            DemoSectionView("Snackbar") {
                Snackbar("Changes saved", isPresented: .constant(true))

                Snackbar(isPresented: .constant(true)) {
                    Text("With an action")
                } actions: {
                    Button("Undo") {}
                }
            }

            DemoSectionView("Toggle") {
                Button("Toggle snackbar") {
                    isPresented.toggle()
                }
                .buttonStyle(.primary)
                .accessibilityIdentifier("toggleSnackbarButton")

                if isPresented {
                    Snackbar("Visible", isPresented: $isPresented)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SnackbarDemo()
    }
}
