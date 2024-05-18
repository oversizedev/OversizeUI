//
// Copyright © 2021 Alexander Romanov
// RowLabelStyle.swift, created on 23.12.2022
//

import SwiftUI

public struct RowLabelStyle: LabelStyle {
    @Environment(\.sizeCategory) var sizeCategory
    @Environment(\.multilineTextAlignment) var multilineTextAlignment

    private let subtitle: String?

    public init(subtitle: String? = nil) {
        self.subtitle = subtitle
    }

    public func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: .xSmall) {
            configuration.icon
                .headline()
                .foregroundColor(.onSurfaceHighEmphasis)

            VStack(alignment: textAlignment, spacing: .xxxSmall) {
                configuration.title
                    .headline(.semibold)
                    .foregroundColor(.onSurfaceHighEmphasis)

                if let subtitle, !subtitle.isEmpty {
                    Text(subtitle)
                        .subheadline()
                        .foregroundColor(.onSurfaceMediumEmphasis)
                }
            }
        }
        .multilineTextAlignment(multilineTextAlignment)
    }

    private var textAlignment: HorizontalAlignment {
        switch multilineTextAlignment {
        case .leading:
            .leading
        case .center:
            .center
        case .trailing:
            .trailing
        }
    }
}

public extension LabelStyle where Self == RowLabelStyle {
    static var row: RowLabelStyle { .init() }

    static func row(_ subtitle: String?) -> RowLabelStyle {
        RowLabelStyle(subtitle: subtitle)
    }
}

struct RowLabelStyle_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: .large) {
            Label("Text", systemImage: "sun.max")
                .labelStyle(.row)

            Label("Text", systemImage: "sun.max")
                .labelStyle(.row("Subtitle"))
        }
    }
}
