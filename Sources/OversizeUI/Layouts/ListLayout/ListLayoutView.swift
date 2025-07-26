//
// Copyright © 2025 Alexander Romanov
// PageView.swift, created on 01.06.2025
//

import SwiftUI

public struct ListLayoutView<
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
        SwiftUI.List(selection: $selection) {
            content
        }
        .navigationTitle(title)
        .background(background.ignoresSafeArea())
    }

    public init(
        _ title: String,
        @ViewBuilder content: () -> Content,
        @ViewBuilder background: () -> Background = { Color.backgroundPrimary }
    ) where SelectionValue == Never {
        self.title = title
        self.content = content()
        self.background = background()
        _selection = .constant(nil)
    }

    public init(
        _ title: String,
        selection: Binding<Set<SelectionValue>?>,
        @ViewBuilder content: () -> Content,
        @ViewBuilder background: () -> Background = { Color.backgroundPrimary }
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
        ListLayoutView(
            "Title",
            content: {
                ForEach(1 ... 100, id: \.self) { item in
                    VStack(spacing: 0) {
                        Text("Item \(item)")
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .clipShape(Rectangle())
                }
            },
            background: { Color.backgroundSecondary }
        )
        .toolbarTitleDisplayMode(.inline)
        .listStyle(.plain)
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("With Selection") {
    @Previewable @State var selectedItems: Set<Int>? = []

    return NavigationView {
        ListLayoutView(
            "Title with Selection",
            selection: $selectedItems,
            content: {
                ForEach(1 ... 20, id: \.self) { item in
                    Text("Item \(item)")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
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
        ListLayoutView(
            "Title",
            content: { Text("Content") },
            background: { Color.backgroundSecondary }
        )
    }
}
