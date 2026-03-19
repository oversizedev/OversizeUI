//
// Copyright © 2025 Alexander Romanov
// CoverPageView.swift, created on 01.06.2025
//

import SwiftUI

public enum CoverNavigationType {
    case `static`, parallax, pinch
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
public struct CoverLayoutView<
    Content: View,
    Cover: View,
    ContentBackground: View,
    CoverBackground: View,
    Background: View
>: View {
    public typealias ScrollAction = @MainActor @Sendable (_ offset: CGPoint, _ headerVisibleRatio: CGFloat) -> Void

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

    @State private var scrollOffset: CGPoint = .zero
    @State private var visibleRatio: CGFloat = 0
    @State private var topSafeAreaInset: CGFloat = 0

    public var body: some View {
        ZStack(alignment: .top) {
            coverBackground
                .ignoresSafeArea(edges: .top)
                .frame(height: coverBackgroundScrollHeight)
                .offset(y: coverScrollOffset)

            cover
                .frame(height: coverScrollHeight)
                .offset(y: coverScrollOffset)
                .opacity(visibleRatio)

            ScrollView {
                Color.clear
                    .frame(height: 0)
                    .onGeometryChange(for: CGFloat.self) { proxy in
                        proxy.frame(in: .named("CoverScrollView")).minY
                    } action: { minY in
                        handleScrollOffset(CGPoint(x: 0, y: minY))
                    }
                content
                    .background {
                        contentBackground
                            .ignoresSafeArea(edges: .bottom)
                            .cornerRadius(
                                contentCornerRadius,
                                corners: [
                                    .topLeft,
                                    .topRight,
                                ]
                            )
                    }
            }
            .coordinateSpace(.named("CoverScrollView"))
            .safeAreaPadding(.top, coverHeight)
        }
        .navigationTitle(title)
        .background {
            Color.clear
                .ignoresSafeArea()
                .onGeometryChange(for: CGFloat.self) { proxy in
                    proxy.safeAreaInsets.top
                } action: { top in
                    topSafeAreaInset = top
                }
        }
        .background(background.ignoresSafeArea())
    }

    private var coverBackgroundScrollHeight: CGFloat {
        switch coverStyle {
        case .pinch:
            max(0, (coverHeight + topSafeAreaInset) + scrollOffset.y)
        default:
            scrollOffset.y > 0 ? (coverHeight + topSafeAreaInset) + scrollOffset.y : (coverHeight + topSafeAreaInset)
        }
    }

    private var coverScrollHeight: CGFloat {
        switch coverStyle {
        case .pinch:
            max(0, coverHeight + scrollOffset.y)
        default:
            scrollOffset.y > 0 ? coverHeight + scrollOffset.y : coverHeight
        }
    }

    private var coverScrollOffset: CGFloat {
        switch coverStyle {
        case .parallax:
            scrollOffset.y < 0 ? scrollOffset.y / 2 : 0
        default:
            0
        }
    }

    private func handleScrollOffset(_ offset: CGPoint) {
        scrollOffset = offset
        let progress = max(0, min(1, (coverHeight + offset.y) / coverHeight))
        let visibleRatio = easeOut(progress)
        self.visibleRatio = visibleRatio
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
#Preview("Title and subtitle, large") {
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
