//
// Copyright © 2021 Alexander Romanov
// ScreenSizeEnvironment.swift, created on 26.02.2022
//

import SwiftUI

public struct ScreenSize: Sendable {
    public let safeAreaWidth: CGFloat
    public let safeAreaHeight: CGFloat
    public let safeAreaTop: CGFloat
    public let safeAreaBottom: CGFloat
    public let safeAreaLeading: CGFloat
    public let safeAreaTrailing: CGFloat

    public var width: CGFloat {
        safeAreaLeading + safeAreaWidth + safeAreaTrailing
    }

    public var height: CGFloat {
        safeAreaTop + safeAreaHeight + safeAreaBottom
    }

    public init(width: CGFloat, height: CGFloat) {
        safeAreaWidth = width
        safeAreaHeight = height
        safeAreaTop = 0
        safeAreaBottom = 0
        safeAreaLeading = 0
        safeAreaTrailing = 0
    }

    public init(
        width: CGFloat,
        height: CGFloat,
        safeAreaTop: CGFloat,
        safeAreaBottom: CGFloat,
        safeAreaLeading: CGFloat,
        safeAreaTrailing: CGFloat
    ) {
        safeAreaWidth = width
        safeAreaHeight = height
        self.safeAreaTop = safeAreaTop
        self.safeAreaBottom = safeAreaBottom
        self.safeAreaLeading = safeAreaLeading
        self.safeAreaTrailing = safeAreaTrailing
    }

    public init(geometry: GeometryProxy) {
        self.init(
            width: geometry.size.width,
            height: geometry.size.height,
            safeAreaTop: geometry.safeAreaInsets.top,
            safeAreaBottom: geometry.safeAreaInsets.bottom,
            safeAreaLeading: geometry.safeAreaInsets.leading,
            safeAreaTrailing: geometry.safeAreaInsets.trailing
        )
    }
}

private struct ScreenSizeKey: EnvironmentKey {
    static let defaultValue: ScreenSize = .init(width: 375, height: 667)
}

public extension EnvironmentValues {
    var screenSize: ScreenSize {
        get { self[ScreenSizeKey.self] }
        set { self[ScreenSizeKey.self] = newValue }
    }
}

public extension View {
    func screenSize(_ geometry: GeometryProxy) -> some View {
        environment(\.screenSize, ScreenSize(geometry: geometry))
    }

    func screenSize(_ screenSize: ScreenSize) -> some View {
        environment(\.screenSize, screenSize)
    }
}
