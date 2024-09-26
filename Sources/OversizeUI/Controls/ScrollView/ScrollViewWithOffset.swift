//
// Copyright © 2021 Alexander Romanov
// ScrollViewOffset.swift, created on 06.04.2021
//

import SwiftUI

public struct ScrollViewWithOffsetTracking<Content: View>: View {
    public typealias ScrollAction = (_ offset: CGPoint) -> Void

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
            ScrollViewOffsetTracker {
                content()
            }
        }.withOffsetTracking(
            coordinateSpaceName: cordinateSpaceName,
            action: onScroll
        )
    }
}

struct ScrollViewOffsetTracker<Content: View>: View {
    private let cordinateSpaceName: String

    init(
        cordinateSpaceName: String = "ScrollView",
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content
        self.cordinateSpaceName = cordinateSpaceName
    }

    private var content: () -> Content

    var body: some View {
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
}

private extension ScrollView {
    func withOffsetTracking(
        coordinateSpaceName: String,
        action: @escaping (_ offset: CGPoint) -> Void
    ) -> some View {
        coordinateSpace(name: coordinateSpaceName)
            .onPreferenceChange(ScrollOffsetPreferenceKey.self, perform: action)
    }
}
