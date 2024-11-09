//
// Copyright © 2021 Alexander Romanov
// MenuLabelStyle.swift, created on 23.12.2022
//

import SwiftUI

public struct MenuLabelStyle: LabelStyle {
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
                .foregroundColor(.onSurfacePrimary)

            VStack(alignment: textAlignment, spacing: .xxxSmall) {
                configuration.title
                    .headline(.semibold)
                    .foregroundColor(.onSurfacePrimary)

                if let subtitle, !subtitle.isEmpty {
                    Text(subtitle)
                        .subheadline()
                        .foregroundColor(.onSurfaceSecondary)
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

public extension LabelStyle where Self == MenuLabelStyle {
    static var menu: MenuLabelStyle { .init() }

    static func menu(_ subtitle: String?) -> MenuLabelStyle {
        MenuLabelStyle(subtitle: subtitle)
    }
}

struct MenuLabelStyle_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: .large) {
            Label("Text", systemImage: "sun.max")
                .labelStyle(.menu)

            Label("Text", systemImage: "sun.max")
                .labelStyle(.menu("Subtitle"))
        }
    }
}
