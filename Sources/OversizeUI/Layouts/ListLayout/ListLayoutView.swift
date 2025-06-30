//
// Copyright © 2025 Alexander Romanov
// PageView.swift, created on 01.06.2025
//

import SwiftUI

public struct ListLayoutView<
    Content: View,
    Background: View
>: View {
    public typealias ScrollAction = @MainActor @Sendable (_ offset: CGPoint, _ headerVisibleRatio: CGFloat) -> Void

    @Environment(\.screenSize) private var screenSize

    @ViewBuilder private var content: Content
    @ViewBuilder private let background: Background

    private let title: String

    public var body: some View {
        SwiftUI.List { content }
            .navigationTitle(title)
            .background(background.ignoresSafeArea())
    }

    public init(
        _ title: String,
        @ViewBuilder content: () -> Content,
        @ViewBuilder background: () -> Background = { Color.backgroundPrimary }
    ) {
        self.title = title
        self.content = content()
        self.background = background()
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview {
    NavigationView {
        ListLayoutView(
            "Title",
            content: {
                LazyVStack(spacing: 0) {
                    ForEach(1 ... 100, id: \.self) { item in
                        Button {} label: {
                            VStack(spacing: 0) {
                                Text("Item \(item)")
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                Divider()
                            }
                            .clipShape(Rectangle())
                        }
                    }
                }
            },
            background: { Color.backgroundSecondary }
        )
        .toolbarTitleDisplayMode(.inline)
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview {
    NavigationView {
        ListLayoutView(
            "Title",
            content: { Text("Content") },
            background: { Color.backgroundSecondary }
        )
    }
}
