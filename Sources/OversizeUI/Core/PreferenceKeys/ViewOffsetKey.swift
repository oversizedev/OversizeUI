//
// Copyright © 2021 Alexander Romanov
// ViewOffsetKey.swift, created on 22.03.2022
//

import SwiftUI

public struct ViewOffsetKey: PreferenceKey {
    public static var defaultValue = CGFloat.zero
    public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
