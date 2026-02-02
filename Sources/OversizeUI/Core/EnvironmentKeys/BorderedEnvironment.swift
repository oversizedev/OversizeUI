//
// Copyright © 2021 Alexander Romanov
// BorderedEnvironment.swift, created on 21.07.2022
//

import SwiftUI

public extension EnvironmentValues {
    @Entry var isBordered: Bool = false
}

public extension View {
    func bordered(_ isBordered: Bool = true) -> some View {
        environment(\.isBordered, isBordered)
    }
}
