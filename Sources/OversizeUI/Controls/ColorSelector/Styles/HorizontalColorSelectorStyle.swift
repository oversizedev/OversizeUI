//
// Copyright © 2021 Alexander Romanov
// HorizontalColorSelectorStyle.swift, created on 02.02.2023
//

import SwiftUI

public struct HorizontalColorSelectorStyle: ColorSelectorStyle {
    public init() {}
    public func makeBody(configuration: Configuration) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                configuration.label
            }
            .padding(.horizontal, .medium)
        }
        .padding(.vertical)
    }
}
