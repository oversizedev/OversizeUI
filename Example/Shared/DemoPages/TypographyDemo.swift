//
// Copyright © 2026 Alexander Romanov
// TypographyDemo.swift, created on 06.09.2026
//

import OversizeUI
import SwiftUI

struct TypographyDemo: View {
    var body: some View {
        DemoScreen {
            DemoSectionView("Titles") {
                Text("largeTitle").largeTitle()
                Text("title").title()
                Text("title2").title2()
                Text("title3").title3()
            }

            DemoSectionView("Body") {
                Text("headline").headline()
                Text("subheadline").subheadline()
                Text("body").body()
                Text("callout").callout()
            }

            DemoSectionView("Small") {
                Text("footnote").footnote()
                Text("caption").caption()
                Text("caption2").caption2()
            }

            DemoSectionView("Weights") {
                Text("body regular").body()
                Text("body medium").body(.medium)
                Text("body semibold").body(.semibold)
                Text("body bold").body(.bold)
            }
        }
    }
}

#Preview {
    NavigationStack {
        TypographyDemo()
    }
}
