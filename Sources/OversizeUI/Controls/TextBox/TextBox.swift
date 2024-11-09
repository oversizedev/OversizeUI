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
            Text(title)
                .font(titleFont)
                .onSurfacePrimaryForeground()

            subtitle.map {
                Text($0)
                    .font(subtitleFont)
                    .onSurfaceSecondaryForeground()
            }
        }
        .multilineTextAlignment(multilineTextAlignment)
    }

    private var textSpacing: Space {
        if let spacing {
            spacing
        } else {
            switch size {
            case .small:
                .xxxSmall
            case .medium:
                .small
            case .large:
                .medium
            }
        }
    }

    private var textStackAlignment: HorizontalAlignment {
        switch multilineTextAlignment {
        case .leading:
            .leading
        case .center:
            .center
        case .trailing:
            .trailing
        }
    }

    private var titleFont: Font {
        switch size {
        case .small:
            .headline.weight(.semibold)

        case .medium:
            .title2.weight(.bold)

        case .large:
            .title.weight(.semibold)
        }
    }

    private var subtitleFont: Font {
        switch size {
        case .small:
            .callout.weight(.regular)
        default:
            .body.weight(.medium)
        }
    }

    public func textBoxSize(_ size: TextBoxSize) -> TextBox {
        var control = self
        control.size = size
        return control
    }
}
