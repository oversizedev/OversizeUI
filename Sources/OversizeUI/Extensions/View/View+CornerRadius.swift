//
// Copyright © 2021 Alexander Romanov
// Created on 11.09.2021
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
