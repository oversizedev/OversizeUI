//
// Copyright © 2023 Aleksandr Romanov
// FieldPositionEnvironment.swift, created on 03.04.2023
//

import SwiftUI

public enum FieldPosition {
    case `default`, top, bottom, center
}

private struct FieldPositionKey: EnvironmentKey {
    public static var defaultValue: FieldPosition = .default
}

public extension EnvironmentValues {
    var fieldPosition: FieldPosition {
        get { self[FieldPositionKey.self] }
        set { self[FieldPositionKey.self] = newValue }
    }
}

public extension View {
    func fieldPosition(_ position: FieldPosition) -> some View {
        environment(\.fieldPosition, position)
    }
}
