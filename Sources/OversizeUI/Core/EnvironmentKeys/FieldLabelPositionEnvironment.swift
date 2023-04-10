//
// Copyright © 2023 Aleksandr Romanov
// FieldLabelPositionEnvironment.swift, created on 06.03.2023
//

import SwiftUI

public enum FieldLabelPosition {
    case `default`, adjacent, overInput
}

private struct FieldLabelPositionKey: EnvironmentKey {
    public static var defaultValue: FieldLabelPosition = .default
}

public extension EnvironmentValues {
    var fieldLabelPosition: FieldLabelPosition {
        get { self[FieldLabelPositionKey.self] }
        set { self[FieldLabelPositionKey.self] = newValue }
    }
}

public extension View {
    func fieldLabelPosition(_ position: FieldLabelPosition) -> some View {
        environment(\.fieldLabelPosition, position)
    }
}
