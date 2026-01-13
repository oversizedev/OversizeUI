//
// Copyright © 2021 Alexander Romanov
// Separator.swift, created on 07.02.2023
//

import SwiftUI

public enum SeparatorAlignment {
    case horizontal
    case vertical
}

public struct Separator: View {
    private let alignment: SeparatorAlignment
    private let padding: CGFloat
    private let lineWidth: CGFloat = 1

    public init(_ alignment: SeparatorAlignment = .horizontal, padding: CGFloat = .zero) {
        self.alignment = alignment
        self.padding = padding
    }

    public var body: some View {
        let isHorizontal = alignment == .horizontal

        return Rectangle()
            .fill(Color.border)
            .frame(
                width: isHorizontal ? nil : lineWidth,
                height: isHorizontal ? lineWidth : nil
            )
        #if !os(macOS)
            .padding(insets(isHorizontal))
        #endif
    }

    private func insets(_ isHorizontal: Bool) -> EdgeInsets {
        if isHorizontal {
            EdgeInsets(
                top: 0,
                leading: padding,
                bottom: 0,
                trailing: padding
            )
        } else {
            EdgeInsets(
                top: padding,
                leading: 0,
                bottom: padding,
                trailing: 0
            )
        }
    }
}

struct Separator_Preview: PreviewProvider {
    static var previews: some View {
        Separator()
            .padding(.vertical)
    }
}
