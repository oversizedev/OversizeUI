//
// Copyright © 2022 Alexander Romanov
// View+CornerRadius.swift
//

#if os(iOS)
    import SwiftUI

    public extension View {
        func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
            clipShape(RoundedRectangleCorner(radius: radius, corners: corners))
        }
    }
#endif
