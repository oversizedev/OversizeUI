//
// Copyright © 2022 Alexander Romanov
// PremiumEnvironment.swift
//

import SwiftUI

private struct PremiumStateKey: EnvironmentKey {
    public static var defaultValue: Bool = false
}

public extension EnvironmentValues {
    var isPremium: Bool {
        get { self[PremiumStateKey.self] }
        set { self[PremiumStateKey.self] = newValue }
    }
}

public extension View {
    func premiumStatus(_ isPremium: Bool) -> some View {
        environment(\.isPremium, isPremium)
    }
}
