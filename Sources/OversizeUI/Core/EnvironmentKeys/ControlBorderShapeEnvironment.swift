//
// Copyright © 2021 Alexander Romanov
// ControlBorderShapeEnvironment.swift, created on 21.07.2022
//

import SwiftUI

public enum ControlBorderShape: Sendable {
    case capsule
    case roundedRectangle(radius: Radius = .medium)
}

private struct ControlBorderShapeKey: EnvironmentKey {
    public static let defaultValue: ControlBorderShape = .roundedRectangle(radius: .medium)
}

public extension EnvironmentValues {
    var controlBorderShape: ControlBorderShape {
        get { self[ControlBorderShapeKey.self] }
        set { self[ControlBorderShapeKey.self] = newValue }
    }
}

public extension View {
    func controlBorderShape(_ controlBorderShape: ControlBorderShape) -> some View {
        environment(\.controlBorderShape, controlBorderShape)
    }
}
