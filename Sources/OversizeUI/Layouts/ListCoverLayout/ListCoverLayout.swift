//
// Copyright © 2026 Alexander Romanov
// ListCoverLayout.swift, created on 30.08.2026
//

import SwiftUI

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
public struct ListCoverLayout<
    Content: View,
    Cover: View,
    CoverBackground: View,
    Background: View,
    SelectionValue: Hashable
>: View {
    @ViewBuilder private var content: Content
    @ViewBuilder private let cover: Cover
    @ViewBuilder private let coverBackground: CoverBackground
    @ViewBuilder private let background: Background

    private let title: String
    private let coverHeight: CGFloat

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

                SwiftUI.List(selection: $selection) {
                    #if os(macOS)
                    Color.clear
                        .frame(height: spacerRowHeight)
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .selectionDisabled()
                        .background {
                            ListScrollOffsetReader { offset in
                                scrollOffset = offset
                            }
                        }
                    #endif
                    SwiftUI.Group(sections: content) { sections in
                        SwiftUI.ForEach(sections) { section in
                            ListLayoutSectionView(section: section)
                        }
                    }
                    .environment(\.listLayoutStyle, listStyle)
                }
                .navigationTitle(title)
                .environment(\.defaultMinListHeaderHeight, 40)
                .environment(\.defaultMinListRowHeight, 56)
                .scrollContentBackground(.hidden)
                #if !os(macOS)
                .contentMargins(.top, resolveContentMarginTop, for: .scrollContent)
                .onScrollGeometryChange(for: CGFloat.self) { proxy in
                    proxy.contentOffset.y + proxy.contentInsets.top
                } action: { _, value in
                    scrollOffset = value
                }
                #endif
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

    #if os(macOS)
    private var spacerRowHeight: CGFloat {
        max(0, resolveContentMarginTop)
    }
    #endif

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

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
#Preview("Basic cover") {
    NavigationStack {
        ListCoverLayout("Albums") {
            Section("Recently added") {
                ForEach(1 ... 10, id: \.self) { item in
                    ListRow("Item \(item)")
                }
            }

            Section("Favorites") {
                ForEach(11 ... 30, id: \.self) { item in
                    ListRow("Item \(item)")
                }
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

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
#Preview("Custom cover background") {
    NavigationStack {
        ListCoverLayout("Albums", coverHeight: 200) {
            Section("Section") {
                ForEach(1 ... 30, id: \.self) { item in
                    ListRow("Item \(item)")
                }
            }
        } cover: {
            Color.clear
        } coverBackground: {
            Color.indigo
        }
        .listLayoutStyle(.insetGrouped)
    }
}

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
#Preview("Stretchy overscroll") {
    NavigationStack {
        ListCoverLayout("Stretch") {
            Section {
                ForEach(1 ... 10, id: \.self) { item in
                    ListRow("Item \(item)")
                }
            }
        } cover: {
            Color.orange.opacity(0.6)
        } coverBackground: {
            Color.orange
        }
        .coverSpacing(.medium)
    }
}
