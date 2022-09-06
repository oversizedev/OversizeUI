//
// Copyright © 2022 Alexander Romanov
// BorderedEnvironment.swift
//

import SwiftUI

private struct BorderedStateKey: EnvironmentKey {
    public static var defaultValue: Bool = false
}

public extension EnvironmentValues {
    var isBordered: Bool {
        get { self[BorderedStateKey.self] }
        set { self[BorderedStateKey.self] = newValue }
    }
}

public extension View {
    func bordered(_ isBordered: Bool = true) -> some View {
        environment(\.isBordered, isBordered)
    }
}
