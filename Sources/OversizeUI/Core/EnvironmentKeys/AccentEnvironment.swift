//
// Copyright © 2021 Alexander Romanov
// AccentEnvironment.swift, created on 21.07.2022
//

import SwiftUI

public extension EnvironmentValues {
    @Entry var isAccent: Bool = false
}

public extension View {
    func accent(_ isAccent: Bool = true) -> some View {
        environment(\.isAccent, isAccent)
    }
}
