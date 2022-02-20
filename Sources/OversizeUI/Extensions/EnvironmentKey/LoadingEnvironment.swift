//
// Copyright © 2022 Alexander Romanov
// LoadingEnvironment.swift
//

import SwiftUI

struct LoadingStateKey: EnvironmentKey {
    public static var defaultValue: Bool = false
}

public extension EnvironmentValues {
    var isLoading: Bool {
        get { self[LoadingStateKey.self] }
        set { self[LoadingStateKey.self] = newValue }
    }
}

public extension View {
    @ViewBuilder
    func loading(_ isLoading: Bool) -> some View {
        environment(\.isLoading, isLoading)
    }
}
