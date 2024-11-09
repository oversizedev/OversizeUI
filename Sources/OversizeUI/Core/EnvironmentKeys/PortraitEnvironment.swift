//
// Copyright © 2021 Alexander Romanov
// PortraitEnvironment.swift, created on 25.04.2022
//

import SwiftUI

private struct PortraitStateKey: EnvironmentKey {
    public static let defaultValue: Bool = false
}

public extension EnvironmentValues {
    var isPortrait: Bool {
        get { self[PortraitStateKey.self] }
        set { self[PortraitStateKey.self] = newValue }
    }
}

public extension View {
    func portraitMode(_ isPortrait: Bool) -> some View {
        environment(\.isPortrait, isPortrait)
    }
}
