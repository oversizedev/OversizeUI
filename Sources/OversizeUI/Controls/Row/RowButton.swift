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
    @Environment(\.multilineTextAlignment) var multilineTextAlignment
    @Environment(\.controlPadding) var controlPadding: ControlPadding
    public var text: String
    public var style: RowButtonStyle
    public var icon: IconsNames
    public var tapAction: () -> Void

    public init(_ text: String,
                style: RowButtonStyle = .row,
                icon: IconsNames = .none,
                action: @escaping () -> Void)
    {
        self.text = text
        self.style = style
        self.icon = icon
        tapAction = action
    }

    public var body: some View {
        VStack(alignment: .leading) {
            Button(action: tapAction) {
                HStack {
                    if multilineTextAlignment == .center || multilineTextAlignment == .trailing {
                        Spacer()
                    }

                    if icon != .none {
                        Surface {
                            Icon(icon)
                        }
                        .surfaceStyle(.secondary)
                        .surfaceContentInsets(.xxSmall)
                    }

                    Text(text)
                        .headline()
                        .foregroundColor(foregroundColor)

                    if multilineTextAlignment == .leading || multilineTextAlignment == .center {
                        Spacer()
                    }
                }
                .padding(.top, controlPadding.top.rawValue - Space.xxSmall.rawValue)
                .padding(.bottom, controlPadding.bottom.rawValue - Space.xxSmall.rawValue)
                .padding(.leading, controlPadding.leading)
                .padding(.trailing, controlPadding.trailing)
            }
            .buttonStyle(.row)
        }
    }

    private var foregroundColor: Color {
        style == .link
            ? Color.link
            : style == .delete
            ? Color.error
            : Color.onSurfaceHighEmphasis
    }
}
