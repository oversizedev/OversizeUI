//
// Copyright © 2021 Alexander Romanov
// View+CornerRadius.swift, created on 11.09.2021
//

import SwiftUI

#if canImport(UIKit)
    public extension View {
        func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
            clipShape(RoundedRectangleCorner(radius: radius, corners: corners))
        }
    }
#endif

#if canImport(AppKit)
    public extension View {
        @available(watchOS, unavailable)
        @available(tvOS, unavailable)
        @available(macOS 14, *)
        func cornerRadius(_ radius: CGFloat, corners: RectCorner) -> some View {
            clipShape(RoundedRectangleCorner(radius: radius, corners: corners))
        }
    }
#endif
