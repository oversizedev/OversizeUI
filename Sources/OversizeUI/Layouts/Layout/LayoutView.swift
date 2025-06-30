//
// Copyright © 2025 Alexander Romanov
// PageView.swift, created on 01.06.2025
//

import SwiftUI

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
public struct LayoutView<
    Content: View,
    Background: View
>: View {
    @Environment(\.screenSize) private var screenSize

    public typealias ScrollAction = @MainActor @Sendable (_ offset: CGPoint, _ headerVisibleRatio: CGFloat) -> Void

    @ViewBuilder private var content: Content
    @ViewBuilder private let background: Background

    private let title: String
    private let onScroll: ScrollAction?

    public var body: some View {
        ScrollView {
            ScrollViewOffsetTracker {
                content
            }
        }
        .scrollViewOffsetTracking(action: handleScrollOffset)
        .navigationTitle(title)
        .background(background.ignoresSafeArea())
    }

    private func handleScrollOffset(_ offset: CGPoint) {
        let calcHeaderHeight = 44 + screenSize.safeAreaTop
        let visibleRatio: CGFloat = (calcHeaderHeight + offset.y) / calcHeaderHeight
        onScroll?(offset, visibleRatio)
    }

    public init(
        _ title: String,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: () -> Content,
        @ViewBuilder background: () -> Background = { Color.backgroundPrimary }
    ) {
        self.title = title
        self.onScroll = onScroll
        self.content = content()
        self.background = background()
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview {
    NavigationView {
        LayoutView(
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
        LayoutView(
            "Title",
            content: { Text("Content") },
            background: { Color.backgroundSecondary }
        )
    }
}
