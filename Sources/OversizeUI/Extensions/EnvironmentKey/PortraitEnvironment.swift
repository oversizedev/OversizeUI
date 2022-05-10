//
// Copyright © 2022 Alexander Romanov
// PortraitEnvironment.swift
//

import SwiftUI

private struct PortraitStateKey: EnvironmentKey {
    public static var defaultValue: Bool = false
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
