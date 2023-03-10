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
            .frame(width: isHorizontal ? nil : 0.5,
                   height: isHorizontal ? 0.5 : nil)
            .padding(insets(isHorizontal))
    }

    private func insets(_ isHorizontal: Bool) -> EdgeInsets {
        if isHorizontal {
            return EdgeInsets(top: 0.5,
                              leading: padding.rawValue,
                              bottom: 0,
                              trailing: padding.rawValue)
        } else {
            return EdgeInsets(top: padding.rawValue,
                              leading: 0.5,
                              bottom: padding.rawValue,
                              trailing: 0)
        }
    }
}

struct Separator_Preview: PreviewProvider {
    static var previews: some View {
        Separator()
            .padding(.vertical)
    }
}
