//
// Copyright © 2021 Alexander Romanov
// NavigatableEnvironment.swift, created on 21.07.2022
//

import SwiftUI

public extension EnvironmentValues {
    @Entry var isNavigatable: Bool = false
}

public extension View {
    func navigatable(_ isNavigatable: Bool = true) -> some View {
        environment(\.isNavigatable, isNavigatable)
    }
}
