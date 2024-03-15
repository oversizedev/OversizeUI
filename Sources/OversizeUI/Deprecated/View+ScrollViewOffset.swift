//
// Copyright © 2021 Alexander Romanov
// View+ScrollViewOffset.swift, created on 22.03.2022
//

import SwiftUI

public extension View {
    func scrollOffset(name: String = "", onChange: @escaping (CGFloat) -> Void) -> some View {
        overlay(
            GeometryReader {
                Color.clear
                    .preference(key: ViewOffsetKey.self,
                                value: -$0.frame(in: name == "" ? .global : .named(name)).origin.y)
            })
            .onPreferenceChange(ViewOffsetKey.self, perform: onChange)
    }
}
