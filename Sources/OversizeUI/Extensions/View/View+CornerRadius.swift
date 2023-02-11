//
// Copyright © 2021 Alexander Romanov
// View+CornerRadius.swift, created on 11.09.2021
//

#if os(iOS)
    import SwiftUI

    public extension View {
        func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
            clipShape(RoundedRectangleCorner(radius: radius, corners: corners))
        }
    }
#endif
