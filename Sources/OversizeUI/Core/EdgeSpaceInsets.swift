//
// Copyright © 2023 Alexander Romanov
// EdgeSpaceInsets.swift
//

import Foundation

public struct EdgeSpaceInsets {
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
}
