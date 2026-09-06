//
// Copyright © 2026 Alexander Romanov
// NoticeDemo.swift, created on 06.09.2026
//

import OversizeUI
import SwiftUI

struct NoticeDemo: View {
    var body: some View {
        DemoScreen {
            DemoSectionView("Basic") {
                NoticeView("Title")

                NoticeView("Title", subtitle: "With a supporting subtitle")
            }

            DemoSectionView("With image") {
                NoticeView("Backup ready", subtitle: "Your data is safe", image: Image.Base.shieldDone)
            }

            DemoSectionView("Closable") {
                NoticeView("Dismissable", subtitle: "Tap the close button") {}
            }

            DemoSectionView("With actions") {
                NoticeView("Update available", subtitle: "Version 2.0 is ready to install") {
                    Button("Update") {}
                    Button("Later") {}
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        NoticeDemo()
    }
}
