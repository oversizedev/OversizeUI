//
// Copyright © 2021 Alexander Romanov
// Created on 13.09.2021
//

import SwiftUI

public struct PaddingModifier: ViewModifier {
    let edges: Edge.Set
    let length: Space
    public func body(content: Content) -> some View {
        content.padding(edges, length.rawValue)
    }
}

public struct ContentPaddingModifier: ViewModifier {
    #if os(iOS)
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    let edges: Edge.Set
    let length = Space.medium
    public func body(content: Content) -> some View {
        content.padding(edges, horizontalSizeClass == .compact
            ? length.rawValue
            : length.rawValue + Space.xSmall.rawValue)
    }
    #else
    let edges: Edge.Set
    let length = Space.medium
    public func body(content: Content) -> some View {
        content.padding(edges, length.rawValue)
    }
    #endif
}

public extension View {
    func padding(_ edges: Edge.Set, _ length: Space) -> some View {
        modifier(PaddingModifier(edges: edges, length: length))
    }

    func padding(_ length: Space) -> some View {
        modifier(PaddingModifier(edges: Edge.Set.all, length: length))
    }
}

public extension View {
    func paddingContent(_ edges: Edge.Set = .horizontal) -> some View {
        modifier(ContentPaddingModifier(edges: edges))
    }
}
