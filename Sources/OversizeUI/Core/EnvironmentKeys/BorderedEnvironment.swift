//
// Copyright © 2021 Alexander Romanov
// BorderedEnvironment.swift, created on 21.07.2022
//

import SwiftUI

public extension EnvironmentValues {
    @Entry var isBordered: Bool = false
}

public extension View {
    @ViewBuilder
    func bordered(_ isBordered: Bool = true) -> some View {
        if #available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *) {
            environment(\.isBordered, isBordered)
                .containerValue(\.isBordered, isBordered)
        } else {
            environment(\.isBordered, isBordered)
        }
    }
}
