//
// Copyright © 2021 Alexander Romanov
// PremiumEnvironment.swift, created on 06.12.2021
//

import SwiftUI

public extension EnvironmentValues {
    @Entry var isPremium: Bool = false
}

public extension View {
    func premiumStatus(_ isPremium: Bool) -> some View {
        environment(\.isPremium, isPremium)
    }
}
