//
// Copyright © 2026 Alexander Romanov
// DemoScreen.swift, created on 06.09.2026
//

import OversizeUI
import SwiftUI

struct DemoScreen<Content: View>: View {
    @ViewBuilder private let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: .medium) {
                content
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.small)
        }
        .background(Color.backgroundSecondary.ignoresSafeArea())
    }
}

struct DemoSectionView<Content: View>: View {
    private let title: String
    @ViewBuilder private let content: Content

    init(_ title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: .xSmall) {
            Text(title)
                .headline(.semibold)
                .onSurfaceSecondary()

            VStack(alignment: .leading, spacing: .xSmall) {
                content
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.small)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color.surfacePrimary)
            )
        }
    }
}

#Preview {
    DemoScreen {
        DemoSectionView("Section") {
            Text("Content")
        }
    }
}
