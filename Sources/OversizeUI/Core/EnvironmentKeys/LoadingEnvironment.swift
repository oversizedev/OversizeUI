//
// Copyright © 2021 Alexander Romanov
// LoadingEnvironment.swift, created on 15.11.2021
//

import SwiftUI

public extension EnvironmentValues {
    @Entry var isLoading: Bool = false
}

public extension View {
    func loading(_ isLoading: Bool) -> some View {
        environment(\.isLoading, isLoading)
    }
}
