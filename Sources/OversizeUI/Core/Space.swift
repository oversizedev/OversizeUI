//
// Copyright © 2021 Alexander Romanov
// Space.swift, created on 04.11.2019
//

import SwiftUI

public enum Space: CGFloat {
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

    #if os(macOS)
    /// 20
    case medium = 20
    #else
    /// 24
    case medium = 24
    #endif

    /// 32
    case large = 32

    /// 48
    case xLarge = 48

    /// 72
    case xxLarge = 72

    /// 96
    case xxxLarge = 96
}
