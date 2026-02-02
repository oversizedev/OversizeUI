//
// Copyright © 2021 Alexander Romanov
// PortraitEnvironment.swift, created on 25.04.2022
//

import SwiftUI

public extension EnvironmentValues {
    @Entry var isPortrait: Bool = false
}

public extension View {
    func portraitMode(_ isPortrait: Bool) -> some View {
        environment(\.isPortrait, isPortrait)
    }
}
