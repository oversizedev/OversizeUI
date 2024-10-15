//
// Copyright © 2021 Alexander Romanov
// SizePreferenceKey.swift, created on 26.02.2023
//

import SwiftUI

public struct SizePreferenceKey: PreferenceKey {
    public static let defaultValue: CGSize = .zero
    public static func reduce(value _: inout CGSize, nextValue _: () -> CGSize) {}
}
