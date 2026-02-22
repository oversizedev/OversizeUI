//
// Copyright © 2021 Alexander Romanov
// ControlPaddingEnvironment.swift, created on 21.07.2022
//

import SwiftUI

public extension View {
    @available(*, deprecated, renamed: "controlMargin")
    func controlPadding(_ length: Space) -> some View {
        environment(\.controlMargin, ControlMargin(length))
    }

    @available(*, deprecated, renamed: "controlMargin", message: "Set paddings with Edges")
    func controlPadding(horizontal: Space = .medium, vertical: Space = .medium) -> some View {
        environment(\.controlMargin, ControlMargin(horizontal: horizontal, vertical: vertical))
    }

    @available(*, deprecated, renamed: "controlMargin")
    func innerPadding(_ length: Space) -> some View {
        environment(\.controlMargin, ControlMargin(length))
    }

    @available(*, deprecated, renamed: "controlMargin")
    func innerPadding(_ edges: Edge.Set, _ length: Space) -> some View {
        environment(\.controlMargin, ControlMargin(edges, length))
    }

    @available(*, deprecated, renamed: "controlMargin")
    func innerPadding(_ edges: [Edge.Set], _ length: Space) -> some View {
        environment(\.controlMargin, ControlMargin(edges, length))
    }
}
