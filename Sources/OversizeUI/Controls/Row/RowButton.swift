//
// Copyright © 2022 Alexander Romanov
// RowButton.swift
//

import SwiftUI

public enum RowButtonStyle {
    case row
    case link
    case delete
}

public struct RowButton: View {
    public var text: String
    public var style: RowButtonStyle
    public var icon: Icons
    public var tapAction: () -> Void

    public init(_ text: String,
                style: RowButtonStyle = .row,
                icon: Icons = .none,
                action: @escaping () -> Void)
    {
        self.text = text
        self.style = style
        self.icon = icon
        tapAction = action
    }

    public var body: some View {
        VStack(alignment: .leading) {
            Button(action: self.tapAction) {
                HStack {
                    if icon != .none {
                        Surface {
                            Icon(icon)
                        }
                        .surfaceStyle(.secondary)
                        .controlPadding(.xxSmall)
                    }

                    Text(text)
                        .fontStyle(.subtitle1)
                        .foregroundColor(style == .link
                            ? Color.link
                            : style == .delete
                            ? Color.error
                            : Color.onSurfaceHighEmphasis)

                    Spacer()
                }
            }

        }.frame(minHeight: 70)
    }
}
