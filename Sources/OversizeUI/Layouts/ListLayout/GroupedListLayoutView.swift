//
// Copyright © 2025 Alexander Romanov
// PageView.swift, created on 01.06.2025
//

import SwiftUI

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
public struct GroupedListLayoutView<
    Content: View,
    Background: View,
    SelectionValue: Hashable
>: View {
    public typealias ScrollAction = @MainActor @Sendable (_ offset: CGPoint, _ headerVisibleRatio: CGFloat) -> Void

    @Environment(\.screenSize) private var screenSize

    @ViewBuilder private var content: Content
    @ViewBuilder private let background: Background

    @Binding private var selection: Set<SelectionValue>?

    private let title: String

    public var body: some View {
        if #available(iOS 26.0, *) {
            SwiftUI.List(selection: $selection) {
                content
                    .listSectionSeparator(.hidden)
                    .listRowSeparator(.hidden)
                    .listRowSpacing(0)
                    .listSectionMargins(.horizontal, .medium)
                    .listSectionMargins(.vertical, .xSmall)
                    .listRowBackground(Color.surfacePrimary)
            }
            .navigationTitle(title)
            .environment(\.defaultMinListHeaderHeight, 40)
            .environment(\.defaultMinListRowHeight, 56)
            .headerProminence(.increased)
            .scrollContentBackground(.hidden)
            .background(background.ignoresSafeArea())
            .listStyle(.insetGrouped)
        } else {
            SwiftUI.List(selection: $selection) {
                content
                    .listSectionSeparator(.hidden)
                    .listRowSeparator(.hidden)
                    .listSectionSpacing(24)
                    .listRowSpacing(0)
            }
            .navigationTitle(title)
            .background(background.ignoresSafeArea())
            .environment(\.defaultMinListHeaderHeight, 40)
            .environment(\.defaultMinListRowHeight, 56)
            .headerProminence(.increased)
            .listStyle(.insetGrouped)
        }
    }

    public init(
        _ title: String,
        @ViewBuilder content: () -> Content,
        @ViewBuilder background: () -> Background = { Color.backgroundSecondary }
    ) where SelectionValue == Never {
        self.title = title
        self.content = content()
        self.background = background()
        _selection = .constant(nil)
    }

    @available(watchOS, unavailable)
    public init(
        _ title: String,
        selection: Binding<Set<SelectionValue>?>,
        @ViewBuilder content: () -> Content,
        @ViewBuilder background: () -> Background = { Color.backgroundSecondary }
    ) {
        self.title = title
        self.content = content()
        self.background = background()
        _selection = selection
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview {
    NavigationView {
        GroupedListLayoutView(
            "Title",
            content: {
                ForEach(1 ... 100, id: \.self) { item in
                    ListRow("Item \(item)")
                }
            }
        )
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, *)
@available(watchOS, unavailable)
#Preview("With Selection") {
    @Previewable @State var selectedItems: Set<Int>? = []

    return NavigationView {
        GroupedListLayoutView(
            "Title with Selection",
            selection: $selectedItems,
            content: {
                ForEach(1 ... 20, id: \.self) { item in
                    ListRow("Item \(item)")
                }
            }
        )
        .toolbarTitleDisplayMode(.inline)
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview {
    NavigationView {
        GroupedListLayoutView(
            "Title",
            content: {
                Text("Content")
            }
        )
    }
}
