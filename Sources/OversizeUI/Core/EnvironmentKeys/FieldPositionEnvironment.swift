//
// Copyright © 2023 Alexander Romanov
// FieldPositionEnvironment.swift, created on 03.04.2023
//

import SwiftUI

private struct FieldPositionKey: EnvironmentKey {
    public static let defaultValue: VerticalAlignment? = nil
}

public extension EnvironmentValues {
    var fieldPosition: VerticalAlignment? {
        get { self[FieldPositionKey.self] }
        set { self[FieldPositionKey.self] = newValue }
    }
}

public extension View {
    func fieldPosition(_ position: VerticalAlignment?) -> some View {
        environment(\.fieldPosition, position)
    }
}
