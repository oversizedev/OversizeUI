//
// Copyright © 2021 Alexander Romanov
// ControlPaddingEnvironment.swift, created on 21.07.2022
//

import SwiftUI

public struct ControlMargin: Sendable {
    public var top: Space = .medium
    public var leading: Space = .medium
    public var bottom: Space = .medium
    public var trailing: Space = .medium

    public init(_ length: Space) {
        top = length
        leading = length
        bottom = length
        trailing = length
    }

    @available(*, deprecated, message: "Set paddings with Edges")
    public init(horizontal: Space, vertical: Space) {
        top = vertical
        leading = horizontal
        bottom = vertical
        trailing = horizontal
    }

    public init(_ edges: Edge.Set, _ length: Space) {
        switch edges {
        case .horizontal:
            leading = length
            trailing = length
        case .vertical:
            top = length
            bottom = length
        case .top:
            top = length
        case .bottom:
            bottom = length
        case .leading:
            leading = length
        case .trailing:
            trailing = length
        case .all:
            top = length
            leading = length
            bottom = length
            trailing = length
        default:
            top = length
            leading = length
            bottom = length
            trailing = length
        }
    }

    public init(_ edges: [Edge.Set], _ length: Space) {
        for edge in edges {
            switch edge {
            case .horizontal:
                leading = length
                trailing = length
            case .vertical:
                top = length
                bottom = length
            case .top:
                top = length
            case .bottom:
                bottom = length
            case .leading:
                leading = length
            case .trailing:
                trailing = length
            case .all:
                top = length
                leading = length
                bottom = length
                trailing = length
            default:
                top = length
                leading = length
                bottom = length
                trailing = length
            }
        }
    }
}

private struct ControlMarginKey: EnvironmentKey {
    public static let defaultValue: ControlMargin = .init(.medium)
}

public extension EnvironmentValues {
    var controlMargin: ControlMargin {
        get { self[ControlMarginKey.self] }
        set { self[ControlMarginKey.self] = newValue }
    }
}

public extension View {
    func controlMargin(_ length: Space) -> some View {
        environment(\.controlMargin, ControlMargin(length))
    }

    func controlMargin(_ edges: Edge.Set, _ length: Space) -> some View {
        environment(\.controlMargin, ControlMargin(edges, length))
    }

    func controlMargin(_ edges: [Edge.Set], _ length: Space) -> some View {
        environment(\.controlMargin, ControlMargin(edges, length))
    }
}

// MARK: Deprecated methods

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
