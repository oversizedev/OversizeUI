//
// Copyright © 2023 Alexander Romanov
// FieldLabelPositionEnvironment.swift, created on 06.03.2023
//

import SwiftUI

public enum FieldLabelPosition: Sendable {
    case `default`, adjacent, overInput
}

public extension EnvironmentValues {
    @Entry var fieldLabelPosition: FieldLabelPosition = .default
}

public extension View {
    func fieldLabelPosition(_ position: FieldLabelPosition) -> some View {
        environment(\.fieldLabelPosition, position)
    }
}
