//
// Copyright © 2021 Alexander Romanov
// Created on 11.09.2021
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
                        Surface(background: .secondary, padding: .xxSmall) {
                            Icon(icon)
                        }
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
