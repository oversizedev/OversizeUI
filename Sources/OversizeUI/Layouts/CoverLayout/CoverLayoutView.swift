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
    Background: View
>: View {
    @Environment(\.screenSize) private var screenSize

    public typealias ScrollAction = @MainActor @Sendable (_ offset: CGPoint, _ headerVisibleRatio: CGFloat) -> Void

    @ViewBuilder private var content: Content
    @ViewBuilder private let cover: Cover
    @ViewBuilder private let background: Background

    private let title: String
    private let coverHeight: CGFloat
    private let onScroll: ScrollAction?
    var coverStyle: CoverNavigationType = .static
    var contentCornerRadius: CGFloat = 0

    @State private var scrollOffset: CGPoint = .zero

    public var body: some View {
        ZStack(alignment: .top) {
            cover
                .ignoresSafeArea(edges: .top)
                .frame(height: coverScrollHeight)
                .offset(y: coverScrollOffset)

            ScrollView {
                ScrollViewOffsetTracker {
                    content
                        .background {
                            background
                                .ignoresSafeArea()
                                .cornerRadius(
                                    contentCornerRadius,
                                    corners: [
                                        .topLeft,
                                        .topRight,
                                    ]
                                )
                        }
                        .padding(.top, contentTopPadding)
                }
            }
        }
        .contentMargins(.top, coverHeight, for: .scrollIndicators)
        .navigationTitle(title)
        .background(background.ignoresSafeArea())
        .scrollViewOffsetTracking(action: handleScrollOffset)
    }

    private var coverScrollHeight: CGFloat {
        switch coverStyle {
        case .pinch:
            if scrollOffset.y > 0 {
                return coverHeight + scrollOffset.y
            } else {
                let dampingFactor: CGFloat = 0.8
                return max(0, coverHeight + (scrollOffset.y * dampingFactor))
            }
        default:
            return scrollOffset.y > 0 ? coverHeight + scrollOffset.y : coverHeight
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

    private var contentTopPadding: CGFloat {
        contentCornerRadius == 0 ? coverHeight : coverHeight - (contentCornerRadius * 1.4)
    }

    private func handleScrollOffset(_ offset: CGPoint) {
        scrollOffset = offset
        let calcHeaderHeight = 44 + screenSize.safeAreaTop
        let visibleRatio: CGFloat = (calcHeaderHeight + offset.y) / calcHeaderHeight
        onScroll?(offset, visibleRatio)
    }

    public init(
        _ title: String,
        coverHeight: CGFloat = 350,
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: () -> Content,
        @ViewBuilder cover: () -> Cover,
        @ViewBuilder background: () -> Background = { Color.backgroundPrimary }
    ) {
        self.title = title
        self.coverHeight = coverHeight
        self.onScroll = onScroll
        self.content = content()
        self.cover = cover()
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
        .overlay {
            Color.red
                .border(Color.blue, width: 1)
        }
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
