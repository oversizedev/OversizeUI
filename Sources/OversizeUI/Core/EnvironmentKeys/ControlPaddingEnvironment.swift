//
// Copyright © 2022 Alexander Romanov
// ControlPaddingEnvironment.swift
//

import SwiftUI

public struct ControlPadding {
    public let horizontal: Space
    public let vertical: Space

    public init(_ all: Space) {
        horizontal = all
        vertical = all
    }

    public init(horizontal: Space, vertical: Space) {
        self.horizontal = horizontal
        self.vertical = vertical
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
    func controlPadding(_ all: Space) -> some View {
        environment(\.controlPadding, ControlPadding(all))
    }

    func controlPadding(horizontal: Space = .medium, vertical: Space = .medium) -> some View {
        environment(\.controlPadding, ControlPadding(horizontal: horizontal, vertical: vertical))
    }
}
