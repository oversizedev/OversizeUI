//
// Copyright © 2021 Alexander Romanov
// Image+Extensions.swift, created on 01.04.2021
//

import SwiftUI

public extension Image {
    func resizeToFill(width: CGFloat, height: CGFloat) -> some View {
        resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height)
    }
}

public extension Image {
    func icon(_ color: Color = Color.onSurfaceHighEmphasis) -> some View {
        renderingMode(.template)
            .foregroundColor(color)
    }
}

public extension Image {
    func icon(_ color: Color = Color.onSurfaceHighEmphasis, size: IconSizes) -> some View {
        renderingMode(.template)
            .resizable()
            .frame(width: size.rawValue, height: size.rawValue)
            .foregroundColor(color)
    }
}
