//
// Copyright © 2021 Alexander Romanov
// BorderedEnvironment.swift, created on 21.07.2022
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
