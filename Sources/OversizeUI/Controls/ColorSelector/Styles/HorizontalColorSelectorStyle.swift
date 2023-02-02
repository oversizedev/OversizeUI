//
// Copyright © 2023 Alexander Romanov
// HorizontalColorSelectorStyle.swift
//

import SwiftUI

public struct HorizontalColorSelectorStyle: ColorSelectorStyle {
    public init() {}
    public func makeBody(configuration: Configuration) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                configuration.label
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
    }
}
