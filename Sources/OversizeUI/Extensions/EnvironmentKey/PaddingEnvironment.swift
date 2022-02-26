//
// Copyright © 2022 Alexander Romanov
// PaddingEnvironment.swift
//

import SwiftUI

private struct ControlPaddingKey: EnvironmentKey {
    public static var defaultValue: Space = .medium
}

public extension EnvironmentValues {
    var controlPadding: Space {
        get { self[ControlPaddingKey.self] }
        set { self[ControlPaddingKey.self] = newValue }
    }
}

public extension View {
    func controlPadding(_ space: Space) -> some View {
        environment(\.controlPadding, space)
    }
}
