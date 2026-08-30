//
// Copyright © 2026 Alexander Romanov
// Layout.swift, created on 07.06.2026
//

import SwiftUI

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
public struct CoverLayout<
    Content: View,
    Cover: View,
    ContentBackground: View,
    CoverBackground: View,
    Background: View
>: View {
    public typealias ScrollAction = @MainActor @Sendable (_ offset: CGFloat, _ headerVisibleRatio: CGFloat) -> Void

    private let title: String
    private let coverHeight: CGFloat
    private let onScroll: ScrollAction?
    @ViewBuilder private var content: Content
    @ViewBuilder private let cover: Cover
    @ViewBuilder private let contentBackground: ContentBackground
    @ViewBuilder private let coverBackground: CoverBackground
    @ViewBuilder private let background: Background

    var coverStyle: CoverNavigationType = .static
    var contentCornerRadius: CGFloat = 0
    var contentOffset: CGFloat = 0

    @State private var scrollOffset: CGFloat = .zero
    @State private var visibleRatio: CGFloat = 1

    public var body: some View {
        ZStack(alignment: .top) {
            cover
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .background {
                    coverBackground
                        .ignoresSafeArea(edges: .all)
                }
                .frame(height: coverStretchHeight)
                .offset(y: coverParallaxOffset)
                .opacity(visibleRatio)

            ScrollView {
                LazyVStack(spacing: .xxSmall) {
                    Group(sections: content) { sections in
                        ForEach(sections) { section in
                            LayoutSectionView(
                                section: section,
                                isFirst: section.id == sections.first?.id,
                                isLast: section.id == sections.last?.id,
                                isStacked: true
                            )
                        }
                    }
                }
                .padding(.horizontal, .xxSmall)
                .background {
                    contentBackground
                        .ignoresSafeArea(edges: .bottom)
                        .if(contentCornerRadius > 0) {
                            $0.cornerRadius(
                                contentCornerRadius,
                                corners: [.topLeft, .topRight]
                            )
                        }
                }
                .padding(.top, contentOffset)
            }
            .safeAreaPadding(.top, coverHeight)
            // .contentMargins(.top, resolveContentMarginTop, for: .scrollContent)
            .onScrollGeometryChange(for: CGFloat.self) { proxy in
                proxy.contentOffset.y + proxy.contentInsets.top
            } action: { _, value in
                updateScrollOffset(value)
            }
        }
        .navigationTitle(title)
        .background {
            background
                .ignoresSafeArea()
        }
    }

    private var coverStretchHeight: CGFloat {
        switch coverStyle {
        case .pinch:
            max(0, coverHeight - scrollOffset)
        default:
            coverHeight + max(0, -scrollOffset)
        }
    }

    private var coverParallaxOffset: CGFloat {
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
        _ title: String = "",
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

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
#Preview {
    NavigationStack {
        CoverLayout("Albums") {
            Section {
                Text("Song 1")
                    .padding()
                Text("Song 2")
                    .padding()
            }

            Section("Inside title") {
                Row("Song 1") {
                    print("")
                }
                Row("Song 2")
                Row("Song 3") {
                    print("")
                }
            }
            #if !os(tvOS) && !os(watchOS)
            .sectionActions {
                Button("Action 1") {}
                Button("Action 2") {}
            }
            #endif

            Section("Person1's Favorites") {
                Text("Song 1")
                Text("Song 2")
                Text("Song 3")
            }

            Section {
                Text("Song 1")
                Text("Song 2")
                Text("Song 3")
            } header: {
                Text("Title")
            } footer: {
                Text("Footer")
            }
        } cover: {
            LinearGradient(
                colors: [Color.surfacePrimary, Color.yellow],
                startPoint: .top,
                endPoint: .bottom
            )
        } coverBackground: {
            Color.red
        }
        .sectionTitlePosition(.inside)
        .bordered()
        .sectionTitleSeparator(.visible)
    }
}
