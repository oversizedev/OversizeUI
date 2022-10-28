//
// Copyright © 2022 Alexander Romanov
// AnyShape.swift
//

import SwiftUI

public struct AnyShape: Shape {
    public var make: (CGRect, inout Path) -> Void

    public init(_ make: @escaping (CGRect, inout Path) -> Void) {
        self.make = make
    }

    public init(_ shape: some Shape) {
        make = { rect, path in
            path = shape.path(in: rect)
        }
    }

    public func path(in rect: CGRect) -> Path {
        Path { [make] in make(rect, &$0) }
    }
}
