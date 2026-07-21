//
// Copyright © 2021 Alexander Romanov
// Space.swift, created on 04.11.2019
//

import SwiftUI

public enum Space: CGFloat, Sendable {
    /// 0
    case zero = 0

    /// 4
    case xxxSmall = 4

    /// 8
    case xxSmall = 8

    /// 12
    case xSmall = 12

    /// 16
    case small = 16

    /// 20
    case regular = 20

    /// 24
    case medium = 24

    /// 32
    case large = 32

    /// 48
    case xLarge = 48

    /// 72
    case xxLarge = 72

    /// 96
    case xxxLarge = 96
}

public extension CGFloat {
    /// 0 spacing.
    static let zero = Space.zero.rawValue
    /// 4 spacing.
    static let xxxSmall = Space.xxxSmall.rawValue
    /// 8 spacing.
    static let xxSmall = Space.xxSmall.rawValue
    /// 12 spacing.
    static let xSmall = Space.xSmall.rawValue
    /// 16 spacing.
    static let small = Space.small.rawValue
    /// 20 spacing.
    static let regular = Space.regular.rawValue
    /// 24 spacing (platform dependent).
    static let medium = Space.medium.rawValue
    /// 32 spacing.
    static let large = Space.large.rawValue
    /// 48 spacing.
    static let xLarge = Space.xLarge.rawValue
    /// 72 spacing.
    static let xxLarge = Space.xxLarge.rawValue
    /// 96 spacing.
    static let xxxLarge = Space.xxxLarge.rawValue
}
