//
// Copyright © 2022 Alexander Romanov
// Image+Extensions.swift
//

import SwiftUI

public extension Image {
    func resizeToFill(width: CGFloat, height: CGFloat) -> some View {
        resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height)
    }
}
