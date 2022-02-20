//
// Copyright © 2022 Alexander Romanov
// View+CornerRadius.swift
//

#if os(iOS)
    import SwiftUI

    public extension View {
        func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
            clipShape(RoundedCorner(radius: radius, corners: corners))
        }
    }

    struct RoundedCorner: Shape {
        public var radius: CGFloat = .infinity
        public var corners: UIRectCorner = .allCorners

        public func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }
#endif
