//
// Copyright © 2021 Alexander Romanov
// Padding.swift, created on 11.09.2021
//

import SwiftUI

public struct PaddingModifier: ViewModifier {
    private let edges: Edge.Set
    private let length: Space
    public nonisolated init(edges: Edge.Set, length: Space) {
        self.edges = edges
        self.length = length
    }

    public func body(content: Content) -> some View {
        content.padding(edges, length.rawValue)
    }
}

public struct PaddingEdgeInsetsModifier: ViewModifier {
    private let insets: EdgeSpaceInsets
    public nonisolated init(insets: EdgeSpaceInsets) {
        self.insets = insets
    }

    public func body(content: Content) -> some View {
        content.padding(
            EdgeInsets(
                top: insets.top.rawValue,
                leading: insets.leading.rawValue,
                bottom: insets.bottom.rawValue,
                trailing: insets.trailing.rawValue
            )
        )
    }
}

public struct ContentPaddingModifier: ViewModifier {
    #if os(iOS)
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    let edges: Edge.Set
    let length = Space.medium
    public func body(content: Content) -> some View {
        content.padding(
            edges,
            horizontalSizeClass == .compact
                ? length.rawValue
                : length.rawValue + .large
        )
    }
    #else
    let edges: Edge.Set
    let length = Space.medium
    public func body(content: Content) -> some View {
        content.padding(edges, length.rawValue)
    }
    #endif
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
public struct ContentMarginsModifier: ViewModifier {
    #if os(iOS)
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    public func body(content: Content) -> some View {
        content
            .contentMargins(.horizontal, horizontalSizeClass == .compact ? .medium : .medium + .large)
            .contentMargins(.vertical, .small)
    }
    #else
    public func body(content: Content) -> some View {
        content.contentMargins(.all, .medium)
    }
    #endif
}

public extension View {
    @_disfavoredOverload
    nonisolated func padding(_ edges: Edge.Set, _ length: Space) -> some View {
        modifier(PaddingModifier(edges: edges, length: length))
    }

    @_disfavoredOverload
    nonisolated func padding(_ length: Space) -> some View {
        modifier(PaddingModifier(edges: Edge.Set.all, length: length))
    }

    nonisolated func padding(_ insets: EdgeSpaceInsets) -> some View {
        modifier(PaddingEdgeInsetsModifier(insets: insets))
    }
}

public extension View {
    nonisolated func paddingContent(_ edges: Edge.Set = .all) -> some View {
        modifier(ContentPaddingModifier(edges: edges))
    }

    @_disfavoredOverload
    @available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
    nonisolated func contentMargins() -> some View {
        modifier(ContentMarginsModifier())
    }
}
