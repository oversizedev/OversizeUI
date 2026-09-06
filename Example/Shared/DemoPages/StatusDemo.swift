//
// Copyright © 2026 Alexander Romanov
// StatusDemo.swift, created on 06.09.2026
//

import OversizeUI
import SwiftUI

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
struct StatusDemo: View {
    var body: some View {
        DemoScreen {
            DemoSectionView("Empty state") {
                EmptyStateView(
                    image: Image.Base.search,
                    title: "Nothing here yet",
                    subtitle: "Items you add will show up in this list"
                ) {
                    Button("Add item") {}
                }
            }

            DemoSectionView("Error") {
                ErrorView(
                    error: NSError(
                        domain: "OversizeUI",
                        code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "Something went wrong"]
                    )
                )
            }

            DemoSectionView("Success") {
                SuccessView(title: "All done", subtitle: "Your changes have been saved") {
                    Button("Done") {}
                }
            }
        }
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview {
    NavigationStack {
        StatusDemo()
    }
}
