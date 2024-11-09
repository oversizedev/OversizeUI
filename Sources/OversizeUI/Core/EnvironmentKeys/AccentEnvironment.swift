//
// Copyright © 2021 Alexander Romanov
// AccentEnvironment.swift, created on 21.07.2022
//

import SwiftUI

private struct AccentStateKey: EnvironmentKey {
    public static let defaultValue: Bool = false
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
