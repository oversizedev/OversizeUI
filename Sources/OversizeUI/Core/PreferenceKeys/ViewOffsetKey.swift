//
// Copyright © 2021 Alexander Romanov
// ViewOffsetKey.swift, created on 22.03.2022
//

import SwiftUI

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
