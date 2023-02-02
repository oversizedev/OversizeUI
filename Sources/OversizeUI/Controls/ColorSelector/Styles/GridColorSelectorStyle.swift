//
// Copyright © 2023 Alexander Romanov
// GridColorSelectorStyle.swift
//

import SwiftUI

public struct GridColorSelectorStyle: ColorSelectorStyle {
    public init() {}
    private let columns = [GridItem(.adaptive(minimum: 44))]

    public func makeBody(configuration: Configuration) -> some View {
        LazyVGrid(columns: columns, spacing: 10) {
            configuration.label
        }.padding()
    }
}
