//
// Copyright © 2021 Alexander Romanov
// ScrollViewOffset.swift, created on 06.04.2021
//

import SwiftUI

public struct ScrollViewWithOffsetTracking<Content: View>: View {
    public typealias ScrollAction = @MainActor @Sendable (_ offset: CGPoint) -> Void

    private let axes: Axis.Set
    private let showsIndicators: Bool
    private let cordinateSpaceName: String
    private let onScroll: ScrollAction
    private let content: () -> Content

    public init(
        _ axes: Axis.Set = .vertical,
        showsIndicators: Bool = true,
        cordinateSpaceName: String = "ScrollView",
        onScroll: ScrollAction? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.axes = axes
        self.showsIndicators = showsIndicators
        self.cordinateSpaceName = cordinateSpaceName
        self.onScroll = onScroll ?? { _ in }
        self.content = content
    }

    public var body: some View {
        ScrollView(axes, showsIndicators: showsIndicators) {
            ZStack(alignment: .top) {
                GeometryReader { geo in
                    Color.clear
                        .preference(
                            key: ScrollOffsetPreferenceKey.self,
                            value: geo.frame(in: .named(cordinateSpaceName)).origin
                        )
                }
                .frame(height: 0)
                content()
            }
        }
        .coordinateSpace(name: cordinateSpaceName)
        .onPreferenceChange(ScrollOffsetPreferenceKey.self) { offset in
            DispatchQueue.main.async {
                onScroll(offset)
            }
        }
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
struct ScrollViewOffsetTracker<Content: View>: View {
    @ViewBuilder private var content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
    }
}

public extension View {
    func scrollViewOffsetTracking(
        action: @escaping @MainActor @Sendable (_ offset: CGPoint) -> Void
    ) -> some View {
        coordinateSpace(name: "ScrollView")
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { offset in
                DispatchQueue.main.async {
                    action(offset)
                }
            }
    }
}
