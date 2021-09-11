//
// Copyright © 2021 Alexander Romanov
// Created on 11.09.2021
//

import SwiftUI

public struct PaddingModifier: ViewModifier {
    let edges: Edge.Set
    let length: Space
    public func body(content: Content) -> some View {
        content.padding(edges, length.rawValue)
    }
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
    func paddingContent(_ edges: Edge.Set = .all) -> some View {
        modifier(PaddingModifier(edges: edges, length: Space.medium))
    }
}
