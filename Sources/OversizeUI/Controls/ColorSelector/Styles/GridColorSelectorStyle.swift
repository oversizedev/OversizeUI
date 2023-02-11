//
// Copyright © 2021 Alexander Romanov
// GridColorSelectorStyle.swift, created on 02.02.2023
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
