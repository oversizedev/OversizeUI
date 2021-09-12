//
// Copyright © 2021 Alexander Romanov
// Created on 12.09.2021
//

import SwiftUI

public enum Radius {
    private var appearanceSettings: AppearanceSettings {
        AppearanceSettings.shared
    }

    /// 8
    case small
    /// 12
    case medium
    /// 16
    case large
    /// 24
    case xLarge

    var rawValue: CGFloat {
        switch self {
        case .small:
            return CGFloat(appearanceSettings.radius)
        case .medium:
            return appearanceSettings.radius == .zero ?.zero : CGFloat(appearanceSettings.radius) * 1.5
        case .large:
            return appearanceSettings.radius == .zero ?.zero : CGFloat(appearanceSettings.radius) * 2
        case .xLarge:
            return appearanceSettings.radius == .zero ?.zero : CGFloat(appearanceSettings.radius) * 3
        }
    }
}

public struct RadiusModifier: ViewModifier {
    let radius: Radius
    public func body(content: Content) -> some View {
        content.cornerRadius(radius.rawValue)
    }
}

public extension View {
    func cornerRadius(_ radius: Radius) -> some View {
        modifier(RadiusModifier(radius: radius))
    }
}
