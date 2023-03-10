//
// Copyright © 2021 Alexander Romanov
// ScrollArrow.swift, created on 06.09.2022
//

import SwiftUI

public struct ScrollArrow: Shape {
    private var width: CGFloat
    private var offset: CGFloat

    public var animatableData: CGFloat {
        get { offset }
        set { offset = newValue }
    }

    public init(width: CGFloat, offset: CGFloat) {
        self.width = width
        self.offset = offset
    }

    public func path(in _: CGRect) -> Path {
        Path { path in
            path.move(to: .zero)
            path.addLine(to: CGPoint(x: width / 2, y: offset))
            path.move(to: CGPoint(x: width / 2, y: offset))
            path.addLine(to: CGPoint(x: width, y: 0))
        }
    }
}
