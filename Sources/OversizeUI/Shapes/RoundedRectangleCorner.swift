//
// Copyright © 2021 Alexander Romanov
// RoundedRectangleCorner.swift, created on 11.09.2021
//

import SwiftUI

#if os(iOS)
    public struct RoundedRectangleCorner: Shape {
        public var radius: CGFloat = .infinity
        public var corners: UIRectCorner = .allCorners

        public init(radius: CGFloat, corners: UIRectCorner) {
            self.radius = radius
            self.corners = corners
        }

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
