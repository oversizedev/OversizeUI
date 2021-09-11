//
// Copyright © 2021 Alexander Romanov
// Created on 11.09.2021
//

import SwiftUI

public enum Radius: CGFloat {
    /// 8
    case small = 8
    /// 12
    case medium = 12
    /// 16
    case large = 16
    /// 24
    case xLarge = 24
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
