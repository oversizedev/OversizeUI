//
// Copyright © 2025 Alexander Romanov
// CoverPageView.swift, created on 01.06.2025
//

import SwiftUI

@available(iOS, introduced: 17.0, deprecated: 18.0, renamed: "CoverLayout")
@available(macOS, introduced: 14.0, deprecated: 15.0, renamed: "CoverLayout")
@available(tvOS, introduced: 17.0, deprecated: 18.0, renamed: "CoverLayout")
@available(watchOS, introduced: 10.0, deprecated: 11.0, renamed: "CoverLayout")
@available(visionOS, introduced: 1.0, deprecated: 2.0, renamed: "CoverLayout")
public struct CoverLayoutView<
    Content: View,
    Cover: View,
    ContentBackground: View,
    CoverBackground: View,
    Background: View
>: View {
    public typealias ScrollAction = @MainActor @Sendable (_ offset: CGFloat, _ headerVisibleRatio: CGFloat) -> Void

    @ViewBuilder private var content: Content
    @ViewBuilder private let cover: Cover
    @ViewBuilder private let contentBackground: ContentBackground
    @ViewBuilder private let coverBackground: CoverBackground
    @ViewBuilder private let background: Background

    private let title: String
    private let coverHeight: CGFloat
    private let onScroll: ScrollAction?
    var coverStyle: CoverNavigationType = .static
    var contentCornerRadius: CGFloat = 0
    var contentOffset: CGFloat = 0

    @State private var scrollOffset: CGFloat = .zero
    @State private var visibleRatio: CGFloat = 1
    @State private var topSafeAreaInset: CGFloat = 0

    public var body: some View {
        ZStack(alignment: .top) {
            cover
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .background {
                    coverBackground
                        .ignoresSafeArea(edges: .all)
                }
                .frame(height: coverStretchHeight)
                .offset(y: coverScrollOffset)
                .opacity(visibleRatio)

            if #available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *) {
                scrollContent
                    .onScrollGeometryChange(for: CGFloat.self) { proxy in
                        proxy.contentOffset.y + proxy.contentInsets.top
                    } action: { _, value in
                        updateScrollOffset(value)
                    }
            } else {
                scrollContentWithFallback
                    .background {
                        Color.clear
                            .ignoresSafeArea()
                            .onGeometryChange(for: CGFloat.self) { proxy in
                                proxy.safeAreaInsets.top
                            } action: { top in
                                topSafeAreaInset = top
                            }
                    }
            }
        }
        .navigationTitle(title)
        .background(
            background
                .ignoresSafeArea()
                .frame(maxWidth: .infinity)
        )
    }

    private var scrollContent: some View {
        ScrollView {
            content
                .background {
                    contentBackground
                        .ignoresSafeArea(edges: .bottom)
                        .cornerRadius(
                            contentCornerRadius,
                            corners: [.topLeft, .topRight]
                        )
                }
                .padding(.top, contentOffset)
        }
        .safeAreaPadding(.top, coverHeight)
    }

    private var scrollContentWithFallback: some View {
        ScrollView {
            Color.clear
                .frame(height: 0)
                .onGeometryChange(for: CGFloat.self) { proxy in
                    proxy.frame(in: .named("CoverScrollView")).minY
                } action: { minY in
                    let normalized = (topSafeAreaInset + coverHeight) - minY
                    updateScrollOffset(normalized)
                }
            content
                .background {
                    contentBackground
                        .ignoresSafeArea(edges: .bottom)
                        .cornerRadius(
                            contentCornerRadius,
                            corners: [.topLeft, .topRight]
                        )
                }
                .padding(.top, contentOffset)
        }
        .coordinateSpace(.named("CoverScrollView"))
        .safeAreaPadding(.top, coverHeight)
    }

    private var coverStretchHeight: CGFloat {
        switch coverStyle {
        case .pinch:
            max(0, coverHeight - scrollOffset)
        default:
            coverHeight + max(0, -scrollOffset)
        }
    }

    private var coverScrollOffset: CGFloat {
        switch coverStyle {
        case .parallax:
            scrollOffset > 0 ? -scrollOffset / 2 : 0
        default:
            0
        }
    }

    private func updateScrollOffset(_ offset: CGFloat) {
        scrollOffset = offset
        let progress = max(0, min(1, (coverHeight - offset) / coverHeight))
        visibleRatio = easeOut(progress)
        onScroll?(offset, visibleRatio)
    }

    private func easeOut(_ t: CGFloat) -> CGFloat {
        1 - pow(1 - t, 2)
    }

    public init(
        _ title: String,
        coverHeight: CGFloat = 300,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: () -> Content,
        @ViewBuilder cover: () -> Cover,
        @ViewBuilder contentBackground: () -> ContentBackground = { Color.backgroundPrimary },
        @ViewBuilder coverBackground: () -> CoverBackground = { Color.backgroundSecondary },
        @ViewBuilder background: () -> Background = { Color.backgroundPrimary }
    ) {
        self.title = title
        self.coverHeight = coverHeight
        self.onScroll = onScroll
        self.content = content()
        self.cover = cover()
        self.contentBackground = contentBackground()
        self.coverBackground = coverBackground()
        self.background = background()
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("Static") {
    CoverLayoutView("Title") {
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
    } cover: {
        LinearGradient(
            colors: [
                Color.surfacePrimary,
                Color.yellow,
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    } coverBackground: {
        Color.red
    } background: {
        Color.surfacePrimary
    }
    .coverStyle(.static)
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("Parallax") {
    CoverLayoutView("Title") {
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
    } cover: {
        LinearGradient(
            colors: [
                Color.surfacePrimary,
                Color.yellow,
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .overlay {
            Color.red
                .border(Color.blue, width: 1)
        }
    } background: {
        Color.surfacePrimary
    }
    .coverStyle(.parallax)
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("Pinch") {
    CoverLayoutView("Title") {
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
    } cover: {
        LinearGradient(
            colors: [
                Color.surfacePrimary,
                Color.yellow,
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .overlay {
            Color.red
                .border(Color.blue, width: 1)
        }
    } background: {
        Color.surfacePrimary
    }
    .coverStyle(.pinch)
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("Title large") {
    NavigationView {
        CoverLayoutView(
            "Title large",
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
            cover: {
                Color.red
            }
        )
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview {
    CoverLayoutView(
        "Title",
        content: { Text("Content") },
        cover: { Image("cover") },
        background: { Color.blue }
    )
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview {
    CoverLayoutView(
        "Title",
        content: { Text("Content") },
        cover: { Image("cover") }
    )
    .toolbar {
        ToolbarItem(placement: .confirmationAction) {
            Button("Cancel") {}
        }
    }
}
