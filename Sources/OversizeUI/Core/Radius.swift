//
// Copyright © 2021 Alexander Romanov
// Radius.swift, created on 27.05.2020
//

import SwiftUI

public enum Radius: Sendable {
    private var theme: ThemeSettings {
        ThemeSettings()
    }

    /// 0
    case zero
    /// 4
    case xSmall
    /// 8
    case small
    /// 12
    case medium
    /// 16
    case large
    /// 24
    case xLarge

    public var rawValue: CGFloat {
        switch self {
        case .zero:
            .zero
        case .xSmall:
            CGFloat(theme.radius / 2)
        case .small:
            CGFloat(theme.radius)
        case .medium:
            theme.radius == .zero ?.zero : CGFloat(theme.radius) * 1.5
        case .large:
            theme.radius == .zero ?.zero : CGFloat(theme.radius) * 2
        case .xLarge:
            theme.radius == .zero ?.zero : CGFloat(theme.radius) * 3
        }
    }
}

public struct RadiusModifier: ViewModifier {
    private let radius: Radius
    public init(radius: Radius) {
        self.radius = radius
    }

    public func body(content: Content) -> some View {
        content.cornerRadius(radius.rawValue)
    }
}

public extension View {
    func cornerRadius(_ radius: Radius) -> some View {
        modifier(RadiusModifier(radius: radius))
    }
}
