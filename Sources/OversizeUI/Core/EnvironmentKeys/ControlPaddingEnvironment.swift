//
// Copyright © 2021 Alexander Romanov
// ControlPaddingEnvironment.swift, created on 21.07.2022
//

import SwiftUI

public struct ControlPadding {
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

private struct ControlPaddingKey: EnvironmentKey {
    public static var defaultValue: ControlPadding = .init(.medium)
}

public extension EnvironmentValues {
    var controlPadding: ControlPadding {
        get { self[ControlPaddingKey.self] }
        set { self[ControlPaddingKey.self] = newValue }
    }
}

public extension View {
    func innerPadding(_ length: Space) -> some View {
        environment(\.controlPadding, ControlPadding(length))
    }

    func innerPadding(_ edges: Edge.Set, _ length: Space) -> some View {
        environment(\.controlPadding, ControlPadding(edges, length))
    }

    func innerPadding(_ edges: [Edge.Set], _ length: Space) -> some View {
        environment(\.controlPadding, ControlPadding(edges, length))
    }
}

// MARK: Deprecated methods

public extension View {
    @available(*, deprecated, renamed: "innerPadding")
    func controlPadding(_ length: Space) -> some View {
        environment(\.controlPadding, ControlPadding(length))
    }

    @available(*, deprecated, renamed: "innerPadding", message: "Set paddings with Edges")
    func controlPadding(horizontal: Space = .medium, vertical: Space = .medium) -> some View {
        environment(\.controlPadding, ControlPadding(horizontal: horizontal, vertical: vertical))
    }
}
