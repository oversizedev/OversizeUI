//
// Copyright © 2021 Alexander Romanov
// ControlPaddingEnvironment.swift, created on 21.07.2022
//

import SwiftUI

public struct ControlMargin: Sendable {
    public var top: CGFloat = .medium
    public var leading: CGFloat = .medium
    public var bottom: CGFloat = .medium
    public var trailing: CGFloat = .medium

    public init(_ length: CGFloat) {
        top = length
        leading = length
        bottom = length
        trailing = length
    }

    @available(*, deprecated, message: "Set paddings with Edges")
    public init(horizontal: CGFloat, vertical: CGFloat) {
        top = vertical
        leading = horizontal
        bottom = vertical
        trailing = horizontal
    }

    public init(_ edges: Edge.Set, _ length: CGFloat) {
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

    public init(_ edges: [Edge.Set], _ length: CGFloat) {
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

public extension EnvironmentValues {
    @Entry var controlMargin: ControlMargin = .init(.medium)
}

public extension View {
    func controlMargin(_ length: CGFloat) -> some View {
        environment(\.controlMargin, ControlMargin(length))
    }

    func controlMargin(_ edges: Edge.Set, _ length: CGFloat) -> some View {
        environment(\.controlMargin, ControlMargin(edges, length))
    }

    func controlMargin(_ edges: [Edge.Set], _ length: CGFloat) -> some View {
        environment(\.controlMargin, ControlMargin(edges, length))
    }
}
