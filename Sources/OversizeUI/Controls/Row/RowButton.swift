//
// Copyright © 2021 Alexander Romanov
// RowButton.swift, created on 20.06.2020
//

import SwiftUI

public enum RowButtonStyle {
    case row
    case link
    case delete
}

public struct RowButton: View {
    @Environment(\.multilineTextAlignment) var multilineTextAlignment
    @Environment(\.controlMargin) var controlPadding: ControlMargin
    public var text: String
    public var style: RowButtonStyle
    public var icon: Image?
    public var tapAction: () -> Void

    public init(
        _ text: String,
        style: RowButtonStyle = .row,
        icon: Image? = nil,
        action: @escaping () -> Void
    ) {
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

                    if let icon {
                        Surface {
                            icon.icon()
                        }
                        .surfaceStyle(.secondary)
                        .surfaceContentMargins(.xxSmall)
                    }

                    Text(text)
                        .headline()
                        .foregroundColor(foregroundColor)

                    if multilineTextAlignment == .leading || multilineTextAlignment == .center {
                        Spacer()
                    }
                }
                .padding(.top, controlPadding.top.rawValue - .xxSmall)
                .padding(.bottom, controlPadding.bottom.rawValue - .xxSmall)
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
            : Color.onSurfacePrimary
    }
}
