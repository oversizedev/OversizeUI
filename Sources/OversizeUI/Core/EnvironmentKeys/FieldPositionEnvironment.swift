//
// Copyright © 2023 Alexander Romanov
// FieldPositionEnvironment.swift, created on 03.04.2023
//

import SwiftUI

public extension EnvironmentValues {
    @Entry var fieldPosition: VerticalAlignment?
}

public extension View {
    func fieldPosition(_ position: VerticalAlignment?) -> some View {
        environment(\.fieldPosition, position)
    }
}
