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
    public typealias ScrollAction = @MainActor @Sendable (_ offset: CGPoint, _ headerVisibleRatio: CGFloat) -> Void

    @ViewBuilder private var content: Content
    @ViewBuilder private let background: Background

    private let title: String
    private let onScroll: ScrollAction?

    @State private var headerHeight: CGFloat = 0

    public var body: some View {
        ScrollView {
            Color.clear
                .frame(height: 0)
                .onGeometryChange(for: CGFloat.self) { proxy in
                    proxy.frame(in: .named("LayoutScrollView")).minY
                } action: { minY in
                    handleScrollOffset(CGPoint(x: 0, y: minY))
                }
            content
        }
        .coordinateSpace(.named("LayoutScrollView"))
        .navigationTitle(title)
        .background {
            Color.clear
                .ignoresSafeArea()
                .onGeometryChange(for: CGFloat.self) { proxy in
                    proxy.safeAreaInsets.top + 44
                } action: { height in
                    let isInitial = headerHeight == 0
                    headerHeight = height
                    if isInitial { onScroll?(.zero, 1.0) }
                }
        }
        .background(background.ignoresSafeArea())
    }

    private func handleScrollOffset(_ offset: CGPoint) {
        guard headerHeight > 0 else { return }
        let visibleRatio: CGFloat = (headerHeight + offset.y) / headerHeight
        onScroll?(offset, visibleRatio)
    }

    public init(
        _ title: String = "",
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
