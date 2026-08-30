//
// Copyright © 2025 Alexander Romanov
// PageView.swift, created on 01.06.2025
//

import SwiftUI

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
public struct ListLayout<
    Content: View,
    Background: View,
    SelectionValue: Hashable
>: View {
    public typealias ScrollAction = @MainActor @Sendable (_ offset: CGPoint, _ headerVisibleRatio: CGFloat) -> Void

    @ViewBuilder private var content: Content
    @ViewBuilder private let background: Background

    @Binding private var selection: Set<SelectionValue>?

    private let title: String

    var listStyle: ListLayoutStyle = .plain

    public var body: some View {
        @ViewBuilder
        var list: some View {
            SwiftUI.List(selection: $selection) {
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
            .background(backgroundView.ignoresSafeArea())
            .scrollContentBackground(.hidden)
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

    public init(
        _ title: String = "",
        @ViewBuilder content: () -> Content,
        @ViewBuilder background: () -> Background = { EmptyView() }
    ) where SelectionValue == Never {
        self.title = title
        self.content = content()
        self.background = background()
        _selection = .constant(nil)
    }

    @available(watchOS, unavailable)
    public init(
        _ title: String = "",
        selection: Binding<Set<SelectionValue>?>,
        @ViewBuilder content: () -> Content,
        @ViewBuilder background: () -> Background = { EmptyView() }
    ) {
        self.title = title
        self.content = content()
        self.background = background()
        _selection = selection
    }
}

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
#Preview {
    NavigationView {
        ListLayout(
            "Title",
            content: {
                ForEach(1 ... 100, id: \.self) { item in
                    VStack(spacing: 0) {
                        ListRow("Item \(item)")
                    }
                    .clipShape(Rectangle())
                }
            }
        )
        .toolbarTitleDisplayMode(.inline)
        .listStyle(.plain)
    }
}

@available(iOS 18.0, macOS 15.0, tvOS 18.0, visionOS 2.0, *)
@available(watchOS, unavailable)
#Preview("With Selection insetGrouped") {
    @Previewable @State var selectedItems: Set<Int>? = []

    NavigationView {
        ListLayout(
            "Title with Selection",
            selection: $selectedItems,
            content: {
                Section("Title") {
                    ForEach(1 ... 5, id: \.self) { item in
                        ListRow("Item \(item)")
                    }
                }

                Section("Title") {
                    ForEach(1 ... 5, id: \.self) { item in
                        ListRow("Item \(item)")
                    }
                }
            },
            background: { Color.backgroundSecondary }
        )
        // .listLayoutStyle(.insetGrouped)
        .toolbarTitleDisplayMode(.inline)
    }
}

@available(iOS 18.0, macOS 15.0, tvOS 18.0, visionOS 2.0, *)
@available(watchOS, unavailable)
#Preview("With Selection inset") {
    @Previewable @State var selectedItems: Set<Int>? = []

    return NavigationView {
        ListLayout(
            "Title with Selection",
            selection: $selectedItems,
            content: {
                Section("Title") {
                    ForEach(1 ... 5, id: \.self) { item in
                        ListRow("Item \(item)")
                    }
                }

                Section("Title") {
                    ForEach(1 ... 5, id: \.self) { item in
                        ListRow("Item \(item)")
                    }
                }
            },
            background: { Color.backgroundSecondary }
        )
        // .listLayoutStyle(.inset)
        .toolbarTitleDisplayMode(.inline)
    }
}

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
#Preview {
    NavigationView {
        ListLayout(
            "Title",
            content: { Text("Content") },
            background: { Color.backgroundSecondary }
        )
    }
}
