//
// Copyright © 2022 Alexander Romanov
// ControlBorderShapeEnvironment.swift
//

import SwiftUI

public enum ControlBorderShape {
    case capsule
    case roundedRectangle(radius: Radius = .medium)
}

private struct ControlBorderShapeKey: EnvironmentKey {
    public static var defaultValue: ControlBorderShape = .roundedRectangle(radius: .medium)
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
