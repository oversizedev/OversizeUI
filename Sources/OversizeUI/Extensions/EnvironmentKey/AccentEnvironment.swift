//
// Copyright © 2022 Alexander Romanov
// AccentEnvironment.swift
//

import SwiftUI

private struct AccentStateKey: EnvironmentKey {
    public static var defaultValue: Bool = false
}

public extension EnvironmentValues {
    var isAccent: Bool {
        get { self[AccentStateKey.self] }
        set { self[AccentStateKey.self] = newValue }
    }
}

public extension View {
    func accent(_ isAccent: Bool = true) -> some View {
        environment(\.isAccent, isAccent)
    }
}
