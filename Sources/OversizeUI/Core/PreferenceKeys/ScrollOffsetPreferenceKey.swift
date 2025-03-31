//
// Copyright © 2021 Alexander Romanov
// ScrollOffsetPreferenceKey.swift, created on 26.02.2023
//

import SwiftUI

public struct ScrollOffsetPreferenceKey: PreferenceKey {
    public static let defaultValue: CGPoint = .zero

    public static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
        value = nextValue()
    }
}
