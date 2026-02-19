//
// Copyright © 2021 Alexander Romanov
// IconSizes.swift, created on 13.09.2020
//

import SwiftUI

public enum IconSizes: CaseIterable {
    case xSmall
    case small
    case medium
    case large
    case xLarge

    public var rawValue: CGFloat {
        switch self {
        case .xSmall:
            .xSmall
        case .small:
            .small
        case .medium:
            #if os(macOS)
            20
            #else
            .medium
            #endif
        case .large:
            .large
        case .xLarge:
            .xLarge
        }
    }
}
