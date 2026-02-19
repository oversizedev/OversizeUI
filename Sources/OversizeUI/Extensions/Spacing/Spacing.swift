//
// Copyright © 2021 Alexander Romanov
// Spacing.swift, created on 11.09.2021
//

import SwiftUI

public extension EdgeInsets {
    init(_ all: CGFloat) {
        self = .init(top: all, leading: all, bottom: all, trailing: all)
    }
}

public extension EdgeInsets {
    init(horizontal: CGFloat, vertical: CGFloat) {
        self = .init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }
}
