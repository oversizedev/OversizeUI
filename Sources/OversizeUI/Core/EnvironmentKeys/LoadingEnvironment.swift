//
// Copyright © 2021 Alexander Romanov
// LoadingEnvironment.swift, created on 15.11.2021
//

import SwiftUI

private struct LoadingStateKey: EnvironmentKey {
    public static let defaultValue: Bool = false
}

public extension EnvironmentValues {
    var isLoading: Bool {
        get { self[LoadingStateKey.self] }
        set { self[LoadingStateKey.self] = newValue }
    }
}

public extension View {
    func loading(_ isLoading: Bool) -> some View {
        environment(\.isLoading, isLoading)
    }
}
