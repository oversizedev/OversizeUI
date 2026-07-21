//
// Copyright © 2021 Alexander Romanov
// Spacing.swift, created on 11.09.2021
//

import SwiftUI

public extension SwiftUI.EdgeInsets {
    init(_ all: CGFloat) {
        self = .init(top: all, leading: all, bottom: all, trailing: all)
    }
}

public extension SwiftUI.EdgeInsets {
    init(horizontal: CGFloat, vertical: CGFloat) {
        self = .init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }
}
