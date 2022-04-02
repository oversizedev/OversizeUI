//
// Copyright © 2022 Alexander Romanov
// TextBox.swift
//

import SwiftUI

public struct TextBox: View {
    @Environment(\.multilineTextAlignment) var multilineTextAlignment

    let title: String
    let subtitle: String?

    public init(title: String, subtitle: String?) {
        self.title = title
        self.subtitle = subtitle
    }

    public init(title: String) {
        self.title = title
        subtitle = nil
    }

    public var body: some View {
        VStack(alignment: vStackAlignment, spacing: .medium) {
            Text(title)
                .fontStyle(.title3, color: .onSurfaceHighEmphasis)

            if let subtitle = subtitle {
                Text(subtitle)
                    .fontStyle(.paragraph1, color: .onSurfaceHighEmphasis)
            }
        }
        .multilineTextAlignment(multilineTextAlignment)
    }

    var vStackAlignment: HorizontalAlignment {
        switch multilineTextAlignment {
        case .leading:
            return .leading
        case .center:
            return .center
        case .trailing:
            return .trailing
        }
    }
}
