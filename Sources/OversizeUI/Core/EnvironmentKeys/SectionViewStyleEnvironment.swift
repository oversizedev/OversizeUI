//
// Copyright © 2021 Alexander Romanov
// ScreenSizeEnvironment.swift, created on 10.02.2023
//

import SwiftUI

public extension EnvironmentValues {
    @Entry var sectionViewStyle: SectionViewStyle = .default
}

public extension View {
    func sectionViewStyle(_ sectionViewStyle: SectionViewStyle) -> some View {
        environment(\.sectionViewStyle, sectionViewStyle)
    }
}
