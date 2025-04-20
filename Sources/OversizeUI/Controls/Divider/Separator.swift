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
    private let padding: Space

    public init(_ alignment: SeparatorAlignment = .horizontal, padding: Space = .zero) {
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
                top: 0.5,
                leading: padding.rawValue,
                bottom: 0,
                trailing: padding.rawValue
            )
        } else {
            EdgeInsets(
                top: padding.rawValue,
                leading: 0.5,
                bottom: padding.rawValue,
                trailing: 0
            )
        }
    }

    var lineWidth: CGFloat {
        #if os(macOS)
            return 1
        #else
            return 0.5
        #endif
    }
}

struct Separator_Preview: PreviewProvider {
    static var previews: some View {
        Separator()
            .padding(.vertical)
    }
}
