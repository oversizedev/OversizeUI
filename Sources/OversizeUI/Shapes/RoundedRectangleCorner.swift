//
// Copyright © 2021 Alexander Romanov
// RoundedRectangleCorner.swift, created on 11.09.2021
//

#if os(iOS)
import SwiftUI

@available(watchOS, unavailable)
@available(tvOS, unavailable)
@available(macOS, unavailable)
public struct RoundedRectangleCorner: Shape {
    private var radius: CGFloat = .infinity

    private var corners: UIRectCorner = .allCorners

    @available(watchOS, unavailable)
    @available(tvOS, unavailable)
    @available(macOS, unavailable)
    public init(radius: CGFloat, corners: UIRectCorner) {
        self.radius = radius
        self.corners = corners
    }

    @available(watchOS, unavailable)
    @available(tvOS, unavailable)
    @available(macOS, unavailable)
    public init(radius: Radius, corners: UIRectCorner) {
        self.radius = radius.rawValue
        self.corners = corners
    }

    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
#endif
