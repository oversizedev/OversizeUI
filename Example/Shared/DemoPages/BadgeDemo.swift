//
// Copyright © 2026 Alexander Romanov
// BadgeDemo.swift, created on 06.09.2026
//

import OversizeUI
import SwiftUI

struct BadgeDemo: View {
    var body: some View {
        DemoScreen {
            DemoSectionView("Colors") {
                Badge { Text("Default") }

                Badge(color: .success) { Text("Success") }

                Badge(color: .warning) { Text("Warning") }

                Badge(color: .error) { Text("Error") }
            }

            DemoSectionView("With icon") {
                Badge(color: .accent) {
                    HStack(spacing: .xxxSmall) {
                        Icon(Image.Base.info)
                            .iconSize(.xSmall)

                        Text("Info")
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        BadgeDemo()
    }
}
