//
// Copyright © 2021 Alexander Romanov
// TextBox.swift, created on 02.04.2022
//

import SwiftUI

public struct TextBox: View {
    @Environment(\.multilineTextAlignment) var multilineTextAlignment

    let title: String
    let subtitle: String?
    let spacing: Space?
    var size: TextBoxSize = .medium

    public enum TextBoxSize {
        case small, medium, large
    }

    public init(title: String, subtitle: String?, spacing: Space? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.spacing = spacing
    }

    public init(title: String) {
        self.title = title
        subtitle = nil
        spacing = .medium
    }

    public var body: some View {
        VStack(alignment: textStackAlignment, spacing: textSpacing) {
            titleText

            if let subtitle {
                Text(subtitle)
                    .body(.medium)
                    .foregroundColor(.onSurfaceMediumEmphasis)
            }
        }
        .multilineTextAlignment(multilineTextAlignment)
    }

    private var textSpacing: Space {
        if let spacing {
            return spacing
        } else {
            switch size {
            case .small:
                return .xxxSmall
            case .medium:
                return .small
            case .large:
                return .medium
            }
        }
    }

    private var textStackAlignment: HorizontalAlignment {
        switch multilineTextAlignment {
        case .leading:
            return .leading
        case .center:
            return .center
        case .trailing:
            return .trailing
        }
    }

    private var titleText: some View {
        Group {
            switch size {
            case .small:
                Text(title)
                    .headline(true)
            case .medium:
                Text(title)
                    .title2(true)
            case .large:
                Text(title)
                    .title(true)
            }
        }
        .foregroundOnSurfaceHighEmphasis()
    }

    public func textBoxSize(_ size: TextBoxSize) -> TextBox {
        var control = self
        control.size = size
        return control
    }
}
