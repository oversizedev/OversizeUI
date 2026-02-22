//
// Copyright © 2021 Alexander Romanov
// ControlBorderShapeEnvironment.swift, created on 21.07.2022
//

import SwiftUI

public enum ControlBorderShape: Sendable {
    case capsule
    case roundedRectangle(radius: Space = .xSmall)
}

public extension EnvironmentValues {
    @Entry var controlBorderShape: ControlBorderShape = .roundedRectangle(radius: .xSmall)
}

public extension View {
    func controlBorderShape(_ controlBorderShape: ControlBorderShape) -> some View {
        environment(\.controlBorderShape, controlBorderShape)
    }
}
