//
// Copyright © 2021 Alexander Romanov
// FieldTitleViewModifier.swift, created on 20.02.2023
//

import SwiftUI

public struct FieldTitleViewModifier: ViewModifier {
    @Environment(\.theme) private var theme: ThemeSettings
    private var title: String
    public init(_ title: String) {
        self.title = title
    }

    public func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: .xSmall) {
            Text(title)
                .subheadline(.medium)
                .onSurfaceHighEmphasisForegroundColor()

            content
        }
    }
}

public extension View {
    func fieldTitle(_ title: String) -> some View {
        modifier(FieldTitleViewModifier(title))
    }
}
