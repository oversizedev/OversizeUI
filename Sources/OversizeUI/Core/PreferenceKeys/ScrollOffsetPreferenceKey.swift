//
// Copyright © 2021 Alexander Romanov
// ScrollOffsetPreferenceKey.swift, created on 26.02.2023
//

import SwiftUI

public struct ScrollOffsetPreferenceKey: PreferenceKey {
    public static var defaultValue: [CGFloat] = [0]
    public static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
        value.append(contentsOf: nextValue())
    }
}
