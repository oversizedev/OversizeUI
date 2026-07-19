//
// Copyright © 2025 Alexander Romanov
// CoverPageView.swift, created on 01.06.2025
//

import SwiftUI

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *)
public struct ListCoverLayoutView<
    Content: View,
    Cover: View,
    CoverBackground: View,
    Background: View,
    SelectionValue: Hashable
>: View {
    @ViewBuilder private var content: Content
    @ViewBuilder private let background: Background

    @ViewBuilder private let cover: Cover
    @ViewBuilder private let coverBackground: CoverBackground

    private let coverHeight: CGFloat
    private let title: String

    var listStyle: ListLayoutStyle = .plain
    var contentMarginTop: CGFloat?

    @State private var scrollOffset: CGFloat = .zero

    @Binding private var selection: Set<SelectionValue>?

    public var body: some View {
        @ViewBuilder
        var list: some View {
            ZStack(alignment: .top) {
                cover
                    .zIndex(1)
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .center
                    )
                    .background {
                        coverBackground
                            .ignoresSafeArea(edges: .all)
                    }
                    .frame(height: coverStretchHeight)
                    .offset(y: coverScrollOffset)

                if #available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *) {
                    SwiftUI.List(selection: $selection) {
                        content
                            .environment(\.listLayoutStyle, listStyle)
                    }
                    .navigationTitle(title)
                    .environment(\.defaultMinListHeaderHeight, 40)
                    .environment(\.defaultMinListRowHeight, 56)
                    .scrollContentBackground(.hidden)
                    .contentMargins(.top, resolveContentMarginTop, for: .scrollContent)
                    .onScrollGeometryChange(for: CGFloat.self) { proxy in
                        proxy.contentOffset.y + proxy.contentInsets.top
                    } action: { _, value in
                        scrollOffset = value
                    }
                } else {
                    #if !os(watchOS)
                    SwiftUI.List(selection: $selection) {
                        Color.clear
                            .frame(height: 0)
                            .background {
                                ListScrollOffsetReader { offset in
                                    scrollOffset = offset
                                }
                            }
                        content
                            .environment(\.listLayoutStyle, listStyle)
                    }
                    .if(!title.isEmpty) { $0.navigationTitle(title) }
                    .environment(\.defaultMinListHeaderHeight, 40)
                    .environment(\.defaultMinListRowHeight, 56)
                    .scrollContentBackground(.hidden)
                    .contentMargins(.top, resolveContentMarginTop, for: .scrollContent)
                    #endif
                }
            }
            .background(backgroundView.ignoresSafeArea())
        }

        #if os(iOS)
        @ViewBuilder
        var styledList: some View {
            switch listStyle {
            case .inset:
                list
                    .listStyle(.inset)
            case .grouped, .insetGrouped, .smallInsetGrouped:
                list
                    .listStyle(.insetGrouped)
            case .plain:
                list
                    .listStyle(.plain)
            }
        }
        #elseif os(macOS)
        @ViewBuilder
        var styledList: some View {
            switch listStyle {
            case .inset, .insetGrouped, .smallInsetGrouped, .grouped:
                list
                    .listStyle(.inset)
            case .plain:
                list
                    .listStyle(.plain)
            }
        }
        #else
        @ViewBuilder
        var styledList: some View {
            list.listStyle(.plain)
        }
        #endif

        return styledList
    }

    @ViewBuilder
    private var backgroundView: some View {
        if background.isEmpty {
            listStyle == .plain ? Color.backgroundPrimary : Color.backgroundSecondary
        } else {
            background
        }
    }

    private var coverStretchHeight: CGFloat {
        coverHeight + max(0, -scrollOffset)
    }

    private var coverScrollOffset: CGFloat {
        scrollOffset > 0 ? -scrollOffset : 0
    }

    private var resolveContentMarginTop: CGFloat {
        if let contentMarginTop {
            coverHeight + contentMarginTop
        } else {
            switch listStyle {
            case .plain, .inset, .grouped:
                coverHeight + .zero
            case .insetGrouped:
                coverHeight + .medium
            case .smallInsetGrouped:
                coverHeight + .xxSmall
            }
        }
    }

    // MARK: - Init

    public init(
        _ title: String = "",
        coverHeight: CGFloat = 300,
        @ViewBuilder content: () -> Content,
        @ViewBuilder cover: () -> Cover,
        @ViewBuilder coverBackground: () -> CoverBackground = { Color.backgroundSecondary },
        @ViewBuilder background: () -> Background = { EmptyView() }
    ) where SelectionValue == Never {
        self.title = title
        self.coverHeight = coverHeight
        self.content = content()
        self.cover = cover()
        self.coverBackground = coverBackground()
        self.background = background()
        _selection = .constant(nil)
    }

    @available(watchOS, unavailable)
    public init(
        _ title: String = "",
        coverHeight: CGFloat = 300,
        selection: Binding<Set<SelectionValue>?>,
        @ViewBuilder content: () -> Content,
        @ViewBuilder cover: () -> Cover,
        @ViewBuilder coverBackground: () -> CoverBackground = { Color.backgroundSecondary },
        @ViewBuilder background: () -> Background = { EmptyView() }
    ) {
        self.title = title
        self.coverHeight = coverHeight
        self.content = content()
        self.cover = cover()
        self.coverBackground = coverBackground()
        self.background = background()
        _selection = selection
    }
}

@available(iOS 18.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("Basic cover") {
    NavigationView {
        ListCoverLayoutView("Albums") {
            ForEach(1 ... 30, id: \.self) { item in
                Text("Item \(item)")
            }
        } cover: {
            ZStack {
                Color.red.opacity(0.1)
                Text("Text")
            }
        } coverBackground: {
            LinearGradient(
                colors: [Color.surfacePrimary, Color.yellow],
                startPoint: .top,
                endPoint: .bottom
            )
        }
        .toolbarTitleDisplayMode(.inline)
    }
}

@available(iOS 18.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("Custom cover background") {
    NavigationView {
        ListCoverLayoutView("Albums", coverHeight: 200) {
            ForEach(1 ... 30, id: \.self) { item in
                Text("Item \(item)")
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        } cover: {
            Color.clear
        } coverBackground: {
            Color.indigo
        }
        .listLayoutStyle(.insetGrouped)
    }
}

@available(iOS 18.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("Stretchy overscroll") {
    NavigationView {
        ListCoverLayoutView("Stretch") {
            ForEach(1 ... 10, id: \.self) { item in
                Text("Item \(item)")
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        } cover: {
            Color.orange.opacity(0.6)
        } coverBackground: {
            Color.orange
        }
    }
}
