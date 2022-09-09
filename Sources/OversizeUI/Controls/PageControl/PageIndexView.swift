//
// Copyright © 2022 Alexander Romanov
// PageIndexView.swift
//

import SwiftUI

public struct PageIndexView: View {
    @Binding private var index: Int
    private let maxIndex: Int

    public init(_ index: Binding<Int>, maxIndex: Int) {
        _index = index
        self.maxIndex = maxIndex
    }

    public var body: some View {
        HStack(spacing: 8) {
            ForEach(0 ..< maxIndex, id: \.self) { index in
                Capsule()
                    .fill(index == self.index ? Color.accent : Color.surfaceTertiary)
                    .frame(width: index == self.index ? 28 : 8, height: 8)
                    .animation(.default, value: index)
            }
        }
        .padding(12)
        .animation(.default, value: index)
    }
}
