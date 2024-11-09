//
// Copyright © 2021 Alexander Romanov
// EdgeSpaceInsets.swift, created on 07.02.2023
//

import Foundation

public struct EdgeSpaceInsets: Sendable {
    public let top: Space
    public let leading: Space
    public let bottom: Space
    public let trailing: Space

    public init(top: Space, leading: Space, bottom: Space, trailing: Space) {
        self.top = top
        self.leading = leading
        self.bottom = bottom
        self.trailing = trailing
    }

    public init(horizontal: Space, vertical: Space) {
        top = vertical
        leading = horizontal
        bottom = vertical
        trailing = horizontal
    }

    public init(_ all: Space) {
        top = all
        leading = all
        bottom = all
        trailing = all
    }
}
